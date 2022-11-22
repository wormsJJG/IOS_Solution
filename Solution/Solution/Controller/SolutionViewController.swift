//
//  SolutionViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/11/01.
//

import UIKit
import RxSwift
import Then

class SolutionViewController: UIViewController {
    private let cellID: String = "OptionCell"
    var solution: Solution?
    var disposeBag = DisposeBag()
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
    
    private let editButton: UIButton = {
        let button = UIButton().then {
            $0.setTitle("편집", for: .normal)
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
        addObserver()
    }
    
    private func configureNavigationItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if let title = solution?.title {
            self.navigationItem.title = title
        } else {
            self.navigationItem.title = "Error"
        }
        self.navigationController?.navigationBar.tintColor = UIColor.navigationTitleColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationTitleColor!]
        self.pickButton.addTarget(self, action: #selector(didTapRandomOption), for: .touchDown)
        self.editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchDown)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: self.pickButton), UIBarButtonItem(customView: self.editButton)]
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
    // MARK: - Action
    @objc private func didTapRandomOption() {
        let alert = UIAlertController(title: "당신의 \(solution!.title)(은)는", message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in }
            alert.addAction(okAction)
        let messageFontSize = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 40)]
        let messageString = NSAttributedString(string: "\n\(solution!.options.randomElement()!)", attributes: messageFontSize as [NSAttributedString.Key : Any])
            alert.setValue(messageString, forKey: "attributedMessage")
        present(alert, animated: false, completion: nil)
    }
    
    @objc private func didDeleteOption(_ notification: Notification) {
        let option = notification.userInfo!["option"] as! String
        let index = solution!.options.firstIndex(of: option)!
        
        RealmManager.deleteOption(in: solution!, with: index)
        
        RealmManager.getSolution(title: solution!.title)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] solution in
                self?.solution = solution
                self?.optionCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func didTapEditButton() {
        let editVC = AddViewController()
        editVC.isAdding = false
        editVC.title = solution!.title
        editVC.solutionTitle = solution!.title
        var arr: [String] = []
        for option in solution!.options {
            arr.append(option)
        }
        editVC.optionList = arr
        editVC.solution = solution!
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc private func didEdit(_ notification: Notification) {
        let solutionTitle = notification.userInfo!["title"] as! String
        
        RealmManager.getSolution(title: solutionTitle)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] solution in
                self?.title = solutionTitle
                self?.solution = solution
                self?.optionCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    // MARK: - Observer
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDeleteOption(_ :)), name: Notification.Name("optionDelete"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEdit(_ :)), name: Notification.Name("edit"), object: nil)
    }
}
extension SolutionViewController: UICollectionViewDelegate {
}
extension SolutionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sol = solution else { return 1 }
        
        return sol.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? OptionCell else {
            return UICollectionViewCell()
        }
        
        if let sol = solution {
            cell.bindCellData(option: sol.options[indexPath.item])
        } else {
            cell.plainSetting()
        }
        
        return cell
    }
    
    
}
