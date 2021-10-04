//
//  OptionalExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 03/10/21.
//

import Foundation

extension Optional {
    
    var unwrappedString: String {
        if let val = self {
            return val as! String
        }
        return ""
    }
    
    var unwrappedInt: Int {
        if let val = self {
            return val as! Int
        }
        return 0
    }
}
