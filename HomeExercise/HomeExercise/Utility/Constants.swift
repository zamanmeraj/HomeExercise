//
//  Constants.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import Foundation

struct Constants {
    
    struct JSON {
        static let jsonFile = "car_list"
    }
    
    struct Extensions {
        static let json = "json"
    }
    
    struct Fonts {
        static let navigationTitleFont = "TimesNewRomanPS-BoldMT"
        static let prosConsFont = "Helvetica"
        static let carNameFont = "Helvetica-Bold"
    }
    
    struct Title {
        static let title = "GUIDOMIA"
    }
    
    struct Heading {
        static let prosHeading = "Pros :"
        static let consHeading = "Cons :"
    }
    
    struct Cell {
        static let carDetailTableViewCell = "CarDetailTableViewCell"
        static let completeCarCell = "CompleteCarCell"
        static let filterCell = "FilterCell"
    }
    
    struct NibFile {
        static let prosConsView = "ProsConsView"
        static let prosConsList = "ProsConsList"
        static let filterView = "FilterView"
    }
    
    struct Placeholder {
        static let anyMake = "Any make"
        static let anyModel = "Any model"
    }
    
    struct BlankSpace {
        static let space = " "
        static let empty = ""
    }
    
    struct Entity {
        static let carMaker = "CarMaker"
        static let carModel = "CarModel"
        static let pros = "Pros"
        static let cons = "Cons"
        static let isSynced = "isSynced"
    }
    
    struct Filter {
        static let resetFilter = "Reset filter"
    }
}
