//
//  MainViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - UI Component
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureUI()
    }
    
    //MARK: - Configure
    private func configureUI() {
        self.view.backgroundColor = .white

    }
    
    private func configureNavigationItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "고민카드"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationTitleColor!]
    }
}
