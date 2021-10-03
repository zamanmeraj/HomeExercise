//
//  StringExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 02/10/21.
//

import Foundation
import UIKit

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
    
     var attributedPlaceholder: NSAttributedString {
        let attributes:[NSAttributedString.Key: Any] = [.font: UIFont.placeholderFont,
                                                        .foregroundColor: UIColor.lightGray]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
