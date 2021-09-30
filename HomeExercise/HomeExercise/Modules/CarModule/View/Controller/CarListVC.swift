//
//  CarListVC.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import UIKit

class CarListVC: BaseController {

    var carListVCViewModel:CarListVCViewModel?
    fileprivate let cellId = "CarDetailTableViewCell"
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var carListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carListVCViewModel = CarListVCViewModel()
        self.registerCell()
    }
    
    fileprivate func registerCell() {
        self.carListTableView.dataSource = self
        self.carListTableView.delegate = self
        self.carListTableView.register(UINib(nibName: cellId, bundle: .main), forCellReuseIdentifier: cellId)
    }
    
}

extension CarListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carListVCViewModel?.carListModal.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as? CarDetailTableViewCell else { return UITableViewCell() }
        let detail = self.carListVCViewModel?.carListModal[indexPath.row]
        cell.carDetail = detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected index is \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected index is \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension CarListVC: CarListModalViewDelegate {
    func updateCarListModal() {
        self.carListTableView.reloadData()
    }
}
