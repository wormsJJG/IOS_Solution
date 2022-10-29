//
//  MainViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.title = "sss"
    }
}
