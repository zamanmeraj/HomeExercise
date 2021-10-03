//
//  CarListVCViewModel.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation
import UIKit

protocol CarListModalViewDelegate {
    func updateCarListModal()
}

class CarListVCViewModel {
    
    var carListModal: [CarDetails]
    var isExpandStatus = [Bool]()
    
    var carListModalViewDelegate: CarListModalViewDelegate? {
        didSet {
            self.carListModal.enumerated().forEach({ self.isExpandStatus.append($0.0 == 0) })
            self.carListModalViewDelegate?.updateCarListModal()
        }
    }
    
    init() {
        self.carListModal = []
        self.fetchJSONData()
    }
    
    /// Fetch JSON Data from json file and convert it to model.
    private func fetchJSONData(){
        
        let shared = Utility.shared
        let json = Constants.JSON.jsonFile
        let carLists: [CarDetails] = shared.fetchAndParseJSONFile(resource: json)
        self.carListModal = carLists
    }
}
