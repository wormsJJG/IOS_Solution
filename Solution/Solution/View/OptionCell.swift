//
//  OptionCell.swift
//  Solution
//
//  Created by 정재근 on 2022/10/31.
//

import UIKit

class OptionCell: UICollectionViewCell {
    
    private let optionLabel: UILabel = {
        let label = UILabel().then {
            $0.text = "항목을 추가해보세요!"
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 14)
        }
        
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton().then {
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
        }
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func plainSetting() {
        self.optionLabel.text = "항목을 추가해보세요!"
    }
    
    func bindCellData(option: String) {
        self.optionLabel.text = option
    }
    
    private func configureUI() {
        self.backgroundColor = .navigationTitleColor!
        self.layer.cornerRadius = 19
        configureOptionLabel()
        configureDeleteButton()
    }
    
    private func configureOptionLabel() {
        self.addSubview(optionLabel)
        
        optionLabel.snp.makeConstraints { label in
            label.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(8)
            label.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            label.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
    }
    
    private func configureDeleteButton() {
        self.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { button in
            button.left.equalTo(self.optionLabel.snp.right).offset(5)
            button.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            button.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-8)
            button.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
    }
}
