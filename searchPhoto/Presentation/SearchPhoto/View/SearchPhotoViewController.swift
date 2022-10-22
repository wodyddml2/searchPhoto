//
//  SearchPhotoViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

import SnapKit

class SearchPhotoViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        return view
    }()
    
    lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.delegate = self
        return view
    }()

    var dataSource: UICollectionViewDiffableDataSource<Int, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        searchControllerSet()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

extension SearchPhotoViewController {
    private func searchControllerSet() {
        navigationController?.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using:  config)
     
        return layout
    }
    
//    private func 
}

extension SearchPhotoViewController: UICollectionViewDelegate {
    
}

extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
