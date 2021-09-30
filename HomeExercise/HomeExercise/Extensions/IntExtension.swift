//
//  IntExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation
extension Int {
    var roundedWithAbbreviations: String {
//        let number = Double(self)
        let thousand = self / 1000
        let million = self / 1000000
        if million >= 1 {
            return "\(million*10/10)M"
        }
        else if thousand >= 1 {
            return "\(thousand*10/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
