//
//  Utility.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import Foundation
import UIKit

class Utility {
    
    static let shared = Utility()
    
    /// Get all data from given JSON file
    /// - Returns: List of car details
    func fetchAndParseJSONFile<T: Decodable>(resource: String) -> [T] {
        
        let extensionName = Constants.Extensions.json
        
        guard let jsonUrl = Bundle.main.url(forResource: resource, withExtension: extensionName) else { return [] }
        
        do {
            let data = try Data(contentsOf: jsonUrl)
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    /// Get label height
    /// - Parameters:
    ///   - text: Text in the label
    ///   - font: Used font in the label
    ///   - width: Width of the label
    /// - Returns: Height of the label
    func getHeightFor(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let height = text.height(withConstrainedWidth: width, font: font)
        return height
    }
    
}
