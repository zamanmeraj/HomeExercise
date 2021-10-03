//
//  FilterView.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import UIKit

class FilterView: UIView {

    let offset = CGSize(width: -1, height: 1)
    let tableView = UITableView()
    
    @IBOutlet var filterView: UIView!
    
    @IBOutlet weak var carMakeTF: UITextField!{
        didSet {
            self.carMakeTF.attributedPlaceholder = Constants.Placeholder.anyMake.attributedPlaceholder
        }
    }
    
    @IBOutlet weak var carModelTF: UITextField! {
        didSet {
            self.carModelTF.attributedPlaceholder = Constants.Placeholder.anyModel.attributedPlaceholder
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.make(radius: 8.0, backgroundColor: UIColor.appDarkGray)
        }
    }
    
    @IBOutlet weak var anyMakeView: UIView! {
        didSet {
            self.anyMakeView.setShadow(opacity: 0.5, color: .black, offset: offset, radius: 3)
            self.anyMakeView.make(radius: 8.0, backgroundColor: UIColor.white)

        }
    }
    
    @IBOutlet weak var anyModelView: UIView! {
        didSet {
            self.anyModelView.setShadow(opacity: 0.5, color: .black, offset: offset, radius: 3)
            self.anyModelView.make(radius: 8.0, backgroundColor: UIColor.white)
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.commonInit()
        self.setUpTableView()
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self, forCellReuseIdentifier: Constants.Cell.filterCell)
    }
     
    func commonInit() {
        
        Bundle.main.loadNibNamed(Constants.NibFile.filterView, owner: self, options: nil)
        addSubview(filterView)
        filterView.frame = self.bounds
        filterView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}


extension FilterView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.filterCell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat.filterCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
