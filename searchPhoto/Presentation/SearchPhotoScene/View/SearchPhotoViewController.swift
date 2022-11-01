//
//  SearchPhotoViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class SearchPhotoViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        return view
    }()
    
    lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchResultsUpdater = self
        return view
    }()
    
    private let viewModel = SearchPhotoViewModel()

    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        searchControllerSet()
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        bind()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        
        let input = SearchPhotoViewModel.Input(prefetch: collectionView.rx.prefetchItems, search: searchController.searchBar.rx.searchButtonClicked)
        
        let output = viewModel.transform(input: input)
        
        output.photoList
            .withUnretained(self)
            .bind(onNext: { vc, photo in
                guard let dataSource = vc.dataSource else {return}
                var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapshot.appendSections([0]) // enum mainsection
                snapshot.appendItems(photo.results)
                dataSource.apply(snapshot)
        })
        .disposed(by: disposeBag)
        
     
        output.prefetch
            .withUnretained(self)
            .bind(onNext: { vc, item in
                vc.viewModel.paginationRequest(item: item, query: vc.searchController.searchBar.text!)
            })
            .disposed(by: disposeBag)
        
        output.search
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestSearchPhoto(query: vc.searchController.searchBar.text!, page: 1)
            }
            .disposed(by: disposeBag)
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
        let cellRegistration = UICollectionView.CellRegistration<SearchPhotoCollectionViewCell, SearchResult> { cell, indexPath, itemIdentifier in
            let url = URL(string: itemIdentifier.urls.thumb)
            guard let url = url else {return}
            cell.photoImageView.kf.setImage(with: url)
            if itemIdentifier.resultDescription == nil {
                cell.photoTitleLabel.text = "\(self.searchController.searchBar.text!)"
            } else {
                cell.photoTitleLabel.text = itemIdentifier.resultDescription
            }
            
            cell.photoLikeLabel.text = "\(itemIdentifier.likes)"
            cell.photoUpdateLabel.text = itemIdentifier.updatedAt
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    
}

extension SearchPhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {return}
        guard let cell = collectionView.cellForItem(at: indexPath) as? SearchPhotoCollectionViewCell else {return}
        
        viewModel.addFolder(item: item, text: searchController.searchBar.text!)
        DocumentManager.shared.saveImageToDocument(fileName: "\(item.id)", image: cell.photoImageView.image!)
    }
}

extension SearchPhotoViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
}
