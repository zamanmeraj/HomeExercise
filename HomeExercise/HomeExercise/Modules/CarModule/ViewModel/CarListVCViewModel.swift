//
//  CarListVCViewModel.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation
import UIKit
import CoreData

protocol CarListModalViewDelegate {
    func updateCarListModal()
}

class CarListVCViewModel {
    
    var isExpandStatus = [Bool]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var carListModalViewDelegate: CarListModalViewDelegate? {
        didSet {
            Utility.shared.carDetails.enumerated().forEach({ self.isExpandStatus.append($0.0 == 0) })
            self.carListModalViewDelegate?.updateCarListModal()
        }
    }
    
    init() {
        self.fetchJSONData()
    }
    
    /// Fetch JSON Data from json file and convert it to model.
    private func fetchJSONData(){
        let shared = Utility.shared
        let json = Constants.JSON.jsonFile
        let carLists: [CarDetails] = shared.fetchAndParseJSONFile(resource: json)
        if !UserDefaults.standard.bool(forKey: Constants.Entity.isSynced) {
            
            carLists.forEach({ Utility.shared.saveDataInCoreData(detail: $0) })
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.carMaker)
            do {
               _ = try context.fetch(request) as? [CarMaker]
                
            }catch let error {
                print(error.localizedDescription)
            }
        }
        Utility.shared.carDetails = carLists
    }
}
