//
//  NavigationExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import Foundation
import UIKit
extension UINavigationController {
    
    func setBarColor() {
        self.navigationBar.barTintColor = ColorCodes.orange
    }
    
    func setLeftTitle(label text: String) {
        self.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 44))
        titleLabel.font = UIFont.getNavigationTitleFont(name: Constants.Fonts.navigationTitleFont, with: 30)
        titleLabel.text = text
        titleLabel.textColor = .white
        self.navigationBar.addSubview(titleLabel)
    }
    
    
}
