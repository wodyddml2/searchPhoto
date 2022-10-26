//
//  ViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class PhotoFolderViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        return view
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoFolder>?
    
    let viewModel = PhotoFolderViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("FileURL: \(repository.localRealm.configuration.fileURL!)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "검색", style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFolder()
        
        configureDataSource()
      
        viewModel.folder
            .withUnretained(self)
            .bind(onNext: { vc, folder in
                var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoFolder>()
                snapshot.appendSections([0])
                snapshot.appendItems(folder)
                vc.dataSource?.apply(snapshot)
            })
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = createLayout()
    }
    
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func searchButtonTapped() {
        let vc = SearchPhotoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoFolderViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoFolder> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.folderName
            content.secondaryText = "\(itemIdentifier.photoDetail.count)개"
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}

extension PhotoFolderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {return}
        let vc = PhotoViewController()
        vc.viewModel.folderName = item.folderName
        navigationController?.pushViewController(vc, animated: true)
    }
}
