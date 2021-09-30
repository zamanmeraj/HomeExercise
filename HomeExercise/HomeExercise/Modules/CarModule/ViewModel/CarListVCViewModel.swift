//
//  CarListVCViewModel.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation

protocol CarListModalViewDelegate {
    func updateCarListModal()
}

struct CarListVCViewModel {
    
    var carListModalViewDelegate: CarListModalViewDelegate?
    var carListModal: [CarDetails] {
        didSet {
            self.carListModalViewDelegate?.updateCarListModal()
        }
    }
    init() {
        self.carListModal = []
        self.fetchJSONData()
    }
    
    /// Fetch JSON Data from json file and convert it to model.
    mutating func fetchJSONData(){
        guard let carLists = Utility.shared.parseFetchJSONFile() else { return }
        self.carListModal = carLists
    }
    
    
    
}
