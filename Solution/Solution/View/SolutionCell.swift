//
//  solutionCell.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit

class SolutionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCellLayer()
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
}
