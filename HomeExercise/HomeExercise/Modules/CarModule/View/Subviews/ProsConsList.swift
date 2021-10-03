//
//  ProsConsList.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 01/10/21.
//

import UIKit

class ProsConsList: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var bulletLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bulletLbl: UILabel! {
        didSet {
            self.bulletLbl.makeViewCircular()
            self.bulletLbl.backgroundColor = UIColor.appOrange
        }
    }
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            self.titleLbl.font = UIFont.prosConsFont
            self.titleLbl.textColor = UIColor.black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Constants.NibFile.prosConsList, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
