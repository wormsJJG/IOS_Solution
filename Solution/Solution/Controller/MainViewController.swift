//
//  MainViewController.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit
import SnapKit
import Then
import RealmSwift
import RxSwift

class MainViewController: UIViewController {
    private let cellID: String = "solutionCell"
    private let realm = try! Realm()
    private let disposeBag = DisposeBag()
    private var solution: [Solution]?
    private let fileURL = Realm.Configuration.defaultConfiguration.fileURL

    // MARK: - UI Component
    private let solutionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton().then {
            $0.tintColor = UIColor.navigationTitleColor
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 25)
            let image = UIImage(systemName: "plus", withConfiguration: imageConfig)
            $0.setImage(image, for: .normal)
        }
        
        return button
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindSolution()
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindSolution()
    }
    // MARK: - DataFunction
    private func bindSolution() {
        RealmManager.getSolutionList()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] solution in
                self?.solution = solution
                self?.solutionCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
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
        plusButton.addTarget(self, action: #selector(didTapAddSolutionButton), for: .touchDown)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: plusButton)
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
    // MARK: - Action
    @objc func didTapAddSolutionButton() {
        let addView = AddViewController()
        self.navigationController?.pushViewController(addView, animated: true)
    }
    
    @objc func didDeleteSolution() {
        bindSolution()
    }
    // MARK: - Observer
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDeleteSolution), name: Notification.Name("delete"), object: nil)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let solutionView = SolutionViewController()
        guard let solutions = self.solution else {
            return
        }
        solutionView.solution = solutions[indexPath.item]
        self.navigationController?.pushViewController(solutionView, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let solutionList = self.solution else { return 0 }
        
        return solutionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SolutionCell else {
            return UICollectionViewCell()
        }
        if let solutions = self.solution {
            cell.bindData(in: solutions[indexPath.item])
        }
        
        return cell
    }
}
