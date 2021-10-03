//
//  FilterView.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import UIKit

protocol GetMainViewFrameDelegate {
    
    func changeMakeViewFrameWithReferenceToView() -> CGRect
    func changeModelViewFrameWithReferenceToView() -> CGRect
}

protocol AddFilterViewDelegate {
    func addTableViewAsSubview()
    func reloadFilterData(maker: String?, model: String?)
}

class FilterView: UIView {

    let offset = CGSize(width: -1, height: 1)
    let tableView = UITableView()
    let transparentView = UIView()
    
    var filterCarList = [String]()
    var getMainViewFrameDelegate: GetMainViewFrameDelegate?
    var addFilterViewDelegate: AddFilterViewDelegate?
    var selectedDropdown = Dropdown(rawValue: 0)
    
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
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed(Constants.NibFile.filterView, owner: self, options: nil)
        addSubview(filterView)
        filterView.frame = self.bounds
        filterView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self, forCellReuseIdentifier: Constants.Cell.filterCell)
    }
    
    private func createfilterView(frames: CGRect) {
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.transparentView.backgroundColor = UIColor.clear
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        self.addFilterViewDelegate?.addTableViewAsSubview()
        tableView.layer.cornerRadius = 5
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.tableView.frame = CGRect(x: frames.origin.x,
                                                      y: frames.origin.y + frames.height + 5,
                                                      width: frames.width,
                                                      height: CGFloat(self.filterCarList.count * 50))
                       }, completion: nil)
    }
    
    //MARK:- Remove filter view from superview -
    @objc func removeTransparentView() {
        self.transparentView.removeFromSuperview()
        self.tableView.removeFromSuperview()
    }
    
    private func setSelectedIndexValue(_ indexPath: IndexPath) {
        
        switch self.selectedDropdown {
        case .carMaker:
            self.carMakeTF.text = self.filterCarList[indexPath.row]
            self.carModelTF.text = ""
        case .carModel:
            self.carModelTF.text = self.filterCarList[indexPath.row]
        case .none:
            break
        }
        self.addFilterViewDelegate?.reloadFilterData(maker: self.carMakeTF.text, model: self.carModelTF.text)
    }
    
     //MARK:- IBActions -
    @IBAction func anyMakeBtnTapped(_ sender: UIButton) {
        
        self.selectedDropdown = .carMaker
        filterCarList = Utility.shared.getAllMakers()
        let frame = self.getMainViewFrameDelegate?.changeMakeViewFrameWithReferenceToView()
        self.createfilterView(frames: frame!)
        self.tableView.reloadData()
    }
    
    @IBAction func anyModelBtnTapped(_ sender: UIButton) {
        
        self.selectedDropdown = .carModel
        filterCarList = Utility.shared.getAllModels(maker: self.carMakeTF.text)
        let frame = self.getMainViewFrameDelegate?.changeModelViewFrameWithReferenceToView()
        self.createfilterView(frames: frame!)
        self.tableView.reloadData()
    }
}

//MARK:- Filter TableView DataSource and Delegate -
extension FilterView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterCarList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.filterCell, for: indexPath)
        cell.textLabel?.text = filterCarList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat.filterCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.setSelectedIndexValue(indexPath)
        self.removeTransparentView()
    }
}
