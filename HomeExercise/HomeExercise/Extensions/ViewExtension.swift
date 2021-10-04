//
//  ViewExtension.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 01/10/21.
//

import Foundation
import UIKit

extension UIView {
    
    /// Make view round
    func makeViewCircular() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds      = true
    }
    
    /// Set in the view
    /// - Parameters:
    ///   - opacity: Opacity of shadow
    ///   - color: Shadow color
    ///   - offset: Shadow offset
    ///   - radius: Shadow Radius
    func setShadow(opacity: Float = 1.0, color: UIColor, offset: CGSize, radius: CGFloat) {
        self.layer.shadowPath    = UIBezierPath(roundedRect: self.bounds,cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset  = offset
        self.layer.shadowRadius  = radius
        self.layer.masksToBounds = false
    }
    
    class func createProsConsView(frame: CGRect, text: String, isBulletHidden: Bool) -> ProsConsList {
        var givenFrame = frame
        givenFrame.size.height = isBulletHidden ? givenFrame.size.height+18 : givenFrame.size.height+12
        let prosConsList = ProsConsList(frame: givenFrame)
        prosConsList.titleLbl.text = text
        prosConsList.bulletLbl.isHidden = isBulletHidden
        prosConsList.titleLbl.font = isBulletHidden ? UIFont.prosConsHeadingFont : UIFont.prosConsFont
        prosConsList.titleLbl.textColor = isBulletHidden ? UIColor.appDarkGray : UIColor.black
        prosConsList.bulletLeadingConstraint.constant = isBulletHidden ? 20 : 50
        return prosConsList
    }
    
    func make(radius: CGFloat, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
    }
}
