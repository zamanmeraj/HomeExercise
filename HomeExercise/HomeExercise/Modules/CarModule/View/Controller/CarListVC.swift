//
//  CarListVC.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import UIKit

class CarListVC: BaseController {

    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var carListTableView: UITableView!
    
    private var carListVCViewModel:CarListVCViewModel?
    fileprivate let cellId = Constants.Cell.completeCarCell
    private var selectedRow: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialUISetup()
        self.carListVCViewModel = CarListVCViewModel()
        self.carListVCViewModel?.carListModalViewDelegate = self
        self.setupTableView()
    }
    
    private func initialUISetup() {
        
        self.setupNavBar(title: Constants.Title.title)
    }
    
    private func setupTableView() {

        self.carListTableView.dataSource = self
        self.carListTableView.delegate = self
        let nib = UINib(nibName: self.cellId, bundle: .main)
        self.carListTableView.register(nib, forCellReuseIdentifier: self.cellId)
    }
}

extension CarListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.carListVCViewModel?.carListModal.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! CompleteCarCell
        cell.carDetail = self.carListVCViewModel?.carListModal[indexPath.row]
        cell.isExpanded = self.carListVCViewModel?.isExpandStatus[indexPath.row] ?? false
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedRow == indexPath { return }
        carListVCViewModel?.isExpandStatus.enumerated().forEach({ carListVCViewModel?.isExpandStatus[$0.0] = false })
        carListVCViewModel?.isExpandStatus[indexPath.row] = true
        UIView.animate(withDuration: 0.3) {
            self.selectedRow = indexPath
            self.carListTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.carListTableView.reloadData()
        }
    }
}

extension CarListVC: CarListModalViewDelegate {
    
    func updateCarListModal() {
        self.carListTableView.reloadData()
    }
}