//
//  FilterView.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import UIKit

class FilterView: UIView {

    @IBOutlet var filterView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var anyMakeView: UIView!
    @IBOutlet weak var anyModelView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
     
    func commonInit() {
        Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(filterView)
        filterView.frame = self.bounds
        filterView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.setViewLayout()
    }
    
    func setViewLayout() {
        self.make(self.containerView, with: 8, background: ColorCodes.darkGray)
        self.make(self.anyMakeView, with: 8, background: UIColor.white)
        self.make(self.anyModelView, with: 8, background: UIColor.white)
        
    }
    
    func make(_ view: UIView, with radius: Int, background color: UIColor) {
        view.backgroundColor = color
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
    }
    
    
}


