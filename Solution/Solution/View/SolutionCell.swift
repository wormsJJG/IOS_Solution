//
//  solutionCell.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit
import Then

class SolutionCell: UICollectionViewCell {
    private var solution: Solution?
    
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
    
    private let menuButton: UIButton = {
        let button = UIButton().then {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 25)
            let image = UIImage(systemName: "ellipsis", withConfiguration: imageConfig)
            $0.setImage(image, for: .normal)
            $0.tintColor = .white
            $0.showsMenuAsPrimaryAction = true
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
    
    func bindData(in solution: Solution) {
        self.solution = solution
        self.titleLabel.text = solution.title
    }
    
    private func configureUI() {
        setCellLayer()
        configureTitleLabel()
        configureMenuButton()
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
        }
    }
    
    private func configureMenuButton() {
        let deleteSolution = UIAction(title: "고민 삭제", handler: { _ in
            guard let cellSolution = self.solution else { return }
            
            RealmManager.deleteSolution(in: cellSolution)
            NotificationCenter.default.post(name: Notification.Name("delete"), object: nil, userInfo: nil)
        })
        let cancel = UIAction(title: "취소", handler: { _ in
            
        })
        let menu = UIMenu(children: [deleteSolution, cancel])
        menuButton.menu = menu
        
        self.addSubview(menuButton)
        
        menuButton.snp.makeConstraints { button in
            button.width.height.equalTo(36)
            button.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            button.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-8)
        }
    }
}
