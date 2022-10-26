//
//  PhotoViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/23.
//

import UIKit

import Kingfisher
import SnapKit
import RxSwift

final class PhotoViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        return view
    }()
    
    let viewModel = PhotoViewModel()
    
    let disposeBag = DisposeBag()

    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        viewModel.fetchPhoto()
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        viewModel.photo
            .withUnretained(self)
            .bind { vc, photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo)
            vc.dataSource?.apply(snapshot)
        }
            .disposed(by: disposeBag)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

extension PhotoViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PhotoCollectionViewCell, Photo> { cell, indexPath, itemIdentifier in
            cell.photoTitleLabel.text = itemIdentifier.photoDescription
            cell.photoImageView.image = DocumentManager.shared.loadImageFromDocument(fileName: itemIdentifier.photoId)
       
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    

}


