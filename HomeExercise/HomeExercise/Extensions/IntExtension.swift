//
//  IntExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation

extension Int {
    
    var roundedWithAbbreviations: String {
        let thousand = self / 1000
        let million = self / 1000000
        if million >= 1 {
            return "Price : \(million*10/10)m"
        } else if thousand >= 1 {
            return "Price : \(thousand*10/10)k"
        } else {
            return "\(self)"
        }
    }
}
