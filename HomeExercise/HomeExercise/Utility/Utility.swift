//
//  Utility.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import Foundation
class Utility {
    
    static let shared = Utility()
    
    /// Get all data from given JSON file
    /// - Returns: List of car details
    func parseFetchJSONFile() -> [CarDetails]? {
        let resource      = Constants.JSON.jsonFile
        let extensionName = Constants.Extensions.json
        guard let url     = Bundle.main.url(forResource: resource, withExtension: extensionName) else { return nil }
        do {
            let data   = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([CarDetails].self, from: data)
            return result
        }catch let err {
            print(err.localizedDescription)
        }
        return nil
    }
    
}
