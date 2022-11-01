//
//  SolutionViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/11/01.
//

import UIKit

class SolutionViewController: UIViewController {
    private let cellID: String = "OptionCell"
    
    // MARK: - UI Component
    private let optionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        
        return collectionView
    }()
    
    private let pickButton: UIButton = {
        let button = UIButton().then {
            $0.setTitle("뽑기", for: .normal)
            $0.setTitleColor(.navigationTitleColor, for: .normal)
        }
        
        return button
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
        configureOptionCollectionView()
    }
    
    private func configureNavigationItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "제목"
        self.navigationController?.navigationBar.tintColor = UIColor.navigationTitleColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationTitleColor!]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.pickButton)
    }
    
    private func configureOptionCollectionView() {
        optionCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = optionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        self.optionCollectionView.delegate = self
        self.optionCollectionView.dataSource = self
        self.view.addSubview(optionCollectionView)

        self.optionCollectionView.register(OptionCell.self, forCellWithReuseIdentifier: self.cellID)
        
        optionCollectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            collectionView.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            collectionView.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            collectionView.bottom.equalTo(self.view.snp.bottom)
        }
    }
}
extension SolutionViewController: UICollectionViewDelegate {
    
}
extension SolutionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? OptionCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}
