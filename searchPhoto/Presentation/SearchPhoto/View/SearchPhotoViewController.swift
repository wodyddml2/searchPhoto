//
//  SearchPhotoViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

import SnapKit
import Kingfisher

final class SearchPhotoViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        return view
    }()
    
    lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.delegate = self
        view.searchResultsUpdater = self
        return view
    }()
    
    private let viewModel = SearchPhotoViewModel()

    private var dataSource: UICollectionViewDiffableDataSource<Int, Result>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        searchControllerSet()

        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        viewModel.photoList.bind { photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, Result>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo.results)
            self.dataSource?.apply(snapshot)
        }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

extension SearchPhotoViewController {
    private func searchControllerSet() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: size)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SearchPhotoCollectionViewCell, Result> { cell, indexPath, itemIdentifier in
            let url = URL(string: itemIdentifier.urls.thumb)
            guard let url = url else {return}
            cell.photoImageView.kf.setImage(with: url)
            cell.photoLikeLabel.text = "\(itemIdentifier.likes)"
            cell.photoUpdateLabel.text = itemIdentifier.updatedAt
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    
}

extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension SearchPhotoViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}
