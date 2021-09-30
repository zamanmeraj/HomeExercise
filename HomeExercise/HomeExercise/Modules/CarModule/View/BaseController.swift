//
//  BaseController.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
    }

    func setupNavBar() {
        self.navigationController?.setBarColor()
        self.navigationController?.setLeftTitle(label: Constants.Title.title)
    }

}
