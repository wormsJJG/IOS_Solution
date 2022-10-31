//
//  DetailViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/10/31.
//

import UIKit
import TweeTextField
import SnapKit
import Then

class AddViewController: UIViewController {
    private let cellID: String = "OptionCell"
    
    // MARK: - UI Component
    private let addSolutionButton: UIButton = {
        let button = UIButton().then {
            $0.setTitle("추가하기", for: .normal)
            $0.setTitleColor(.navigationTitleColor, for: .normal)
        }
        
        return button
    }()
    
    private let titleTextField: TweeAttributedTextField = {
        let textField = TweeAttributedTextField().then {
            $0.tweePlaceholder = "고민"
            $0.placeholderColor = .navigationTitleColor!
            $0.infoAnimationDuration = 0.7
            $0.infoTextColor = .navigationTitleColor!
            $0.infoFontSize = 13
            $0.activeLineColor = .navigationTitleColor!
            $0.activeLineWidth = 1
            $0.animationDuration = 0.3
            $0.lineColor = .navigationTitleColor!
            $0.lineWidth = 1
        }
        
        return textField
    }()
    
    private let optionTextField: TweeAttributedTextField = {
        let textField = TweeAttributedTextField().then {
            $0.tweePlaceholder = "항목"
            $0.placeholderColor = .navigationTitleColor!
            $0.infoAnimationDuration = 0.7
            $0.infoTextColor = .navigationTitleColor!
            $0.infoFontSize = 13
            $0.activeLineColor = .navigationTitleColor!
            $0.activeLineWidth = 1
            $0.animationDuration = 0.3
            $0.lineColor = .navigationTitleColor!
            $0.lineWidth = 1
        }
        
        return textField
    }()
    
    private let optionCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        
        return collectionview
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
        configureTitleTextField()
        configureOptionTextField()
        configureOptionCollectionView()
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "고민추가"
        addSolutionButton.addTarget(self, action: #selector(didTapPlusSolution), for: .touchDown)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addSolutionButton)
        self.navigationController?.navigationBar.tintColor = UIColor.navigationTitleColor
    }
    
    private func configureTitleTextField() {
        self.view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { textField in
            textField.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            textField.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            textField.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
    }
    
    private func configureOptionTextField() {
        self.view.addSubview(optionTextField)
        
        optionTextField.snp.makeConstraints { textField in
            textField.top.equalTo(self.titleTextField.snp.bottom).offset(20)
            textField.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            textField.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
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
            collectionView.top.equalTo(self.optionTextField.snp.bottom).offset(20)
            collectionView.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            collectionView.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            collectionView.bottom.equalTo(self.view.snp.bottom)
        }
    }
    // MARK: - Action
    @objc func didTapPlusSolution() {
        print("tap")
    }
}

extension AddViewController: UICollectionViewDelegate {
    
}

extension AddViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as? OptionCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - cell 왼쪽 정렬
class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
 
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
 
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
