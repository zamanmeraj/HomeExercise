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
    }

    func setupNavBar(title: String) {
        self.navigationController?.setBarColor()
        self.navigationController?.setLeftTitle(label: title)
    }
}
