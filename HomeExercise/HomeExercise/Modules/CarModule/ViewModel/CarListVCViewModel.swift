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
    
    
    private var selectedRow = IndexPath(row: 0, section: 0)
    private let shared = Utility.shared
    
    var isExpandStatus = [Bool]()
    
    var carListModalViewDelegate: CarListModalViewDelegate? {
        didSet {
            shared.carDetails.enumerated().forEach({ self.isExpandStatus.append($0.0 == 0) })
            self.carListModalViewDelegate?.updateCarListModal()
        }
    }
    
    init() {
        self.fetchJSONData()
    }
    
    /// Fetch JSON Data from json file and convert it to model.
    func fetchJSONData(){
        
        let json = Constants.JSON.jsonFile
        let carLists: [CarDetails] = shared.fetchAndParseJSONFile(resource: json)
        
        if !UserDefaults.standard.bool(forKey: Constants.Entity.isSynced) {
            carLists.forEach({ Utility.shared.saveDataInCoreData(detail: $0) })
            Utility.shared.carDetails = Utility.shared.changeModelToCarMaker(carLists: carLists)
        } else {
            let carMaker = CoreDataManager.shared.fetchCarMakerData()
            Utility.shared.carDetails = carMaker
        }
    }
    
    /// Set expand collapse status for indexPath
    /// - Parameter indexPath: indexPath for
    func setExpandCollapseStatus(indexPath: IndexPath){
        
        if self.selectedRow == indexPath { return }
        
        self.selectedRow = indexPath
        self.isExpandStatus.enumerated().forEach({ self.isExpandStatus[$0.0] = false })
        self.isExpandStatus[indexPath.row] = true
    }
}
