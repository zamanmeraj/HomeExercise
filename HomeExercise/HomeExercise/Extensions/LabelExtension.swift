//
//  LabelExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 02/10/21.
//

import Foundation
import UIKit

extension UILabel {
    
    var carNameHeight: CGFloat {
        return self.text.unwrappedString.height(withConstrainedWidth: self.frame.width,
                                                font: self.font)
    }
    
    var priceLblHeight: CGFloat {
        return self.text.unwrappedString.height(withConstrainedWidth: self.frame.width,
                                                font: self.font)
    }
}
