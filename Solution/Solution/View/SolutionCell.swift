//
//  solutionCell.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit
import Then

class SolutionCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel().then {
            $0.textColor = .white
            $0.font = UIFont.boldSystemFont(ofSize: 19)
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.text = "제목"
        }
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCellLayer()
        configureTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCellLayer() {
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.0
        self.backgroundColor = #colorLiteral(red: 0.4613699913, green: 0.3118675947, blue: 0.8906354308, alpha: 1)
    }
    
    private func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { label in
            label.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(15)
            label.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-15)
            label.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(60)
//            label.centerY.equalToSuperview()
        }
    }
}
