//
//  MainViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    private let cellID: String = "solutionCell"
    // MARK: - UI Component
    private let solutionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure
    private func configureUI() {
        self.view.backgroundColor = .white
        configureNavigationItem()
        configureCollectionView()
    }
    
    private func configureNavigationItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "고민카드"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationTitleColor!]
    }
    
    private func configureCollectionView() {
        solutionCollectionView.delegate = self
        solutionCollectionView.dataSource = self
        self.view.addSubview(solutionCollectionView)
        
        solutionCollectionView.register(SolutionCell.self, forCellWithReuseIdentifier: cellID)
        
        solutionCollectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            collectionView.bottom.equalTo(self.view.snp.bottom)
            collectionView.left.equalTo(self.view.snp.left)
            collectionView.right.equalTo(self.view.snp.right)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SolutionCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
