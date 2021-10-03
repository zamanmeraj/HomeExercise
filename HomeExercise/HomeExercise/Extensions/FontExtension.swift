//
//  FontExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation
import UIKit

extension UIFont {
    
    static func getNavigationTitleFont(name: String, fontSize: CGFloat) -> UIFont? {
        return UIFont(name: name, size: fontSize)
    }
    
    class var priceFont: UIFont {
        return UIFont(name: Constants.Fonts.carNameFont, size: 16)!
    }
    
    class var carNameFont: UIFont {
        return UIFont(name: Constants.Fonts.carNameFont, size: 20)!
    }
    
    class var placeholderFont: UIFont {
        return UIFont(name: Constants.Fonts.carNameFont, size: 17)!
    }
    
    class var prosConsHeadingFont: UIFont {
        return UIFont(name: Constants.Fonts.carNameFont, size: 18)!
    }
    
    class var prosConsFont: UIFont {
        return UIFont(name: Constants.Fonts.carNameFont, size: 16)!
    }
}
