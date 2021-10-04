//
//  CoreDataUtilityManager.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 03/10/21.
//

import Foundation
import CoreData
import UIKit

//CoreDataManager class to fetch data from Database
class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    /// Fetch Car Maker data from datbase
    /// - Returns: Array of CarMaker data
    func fetchCarMakerData() -> [CarMaker] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.carMaker)
        do {
            guard let carMaker = try Utility.shared.context.fetch(request) as? [CarMaker] else { return [] }
            return carMaker
        }catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
