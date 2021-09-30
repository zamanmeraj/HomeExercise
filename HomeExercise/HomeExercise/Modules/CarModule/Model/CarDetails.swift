//
//  CarDetails.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import Foundation
import UIKit

struct CarDetails: Codable {
    var consList:[String]
    var customerPrice: Int
    var make:String
    var marketPrice:Int
    var model: String
    var prosList: [String]
    var rating: Int
    var carImage: String
}
