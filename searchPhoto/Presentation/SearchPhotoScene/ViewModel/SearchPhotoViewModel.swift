//
//  SearchPhotoViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import RxSwift
import RxCocoa
import Alamofire

final class SearchPhotoViewModel {
    
    var photoList = BehaviorSubject(value: SearchPhoto(total: 0, totalPages: 0, results: []))
    // subject error handling, 2단계... Single.......... bonus
    
    let repository = PhotoFolderRepositry()
    
}

extension SearchPhotoViewModel {
    
    func requestSearchPhoto(query: String, page: Int) {
        APIService.searchPhoto(query: query, page: page) { [weak self] (result: Result<SearchPhoto, AFError>) in
            guard let self = self else {return}
            switch result {
            case .success(let photo):
                if page == 1 {
                    self.photoList.onNext(photo)
                } else {
                    do {
                        var value = try self.photoList.value()
                        value.results.append(contentsOf: photo.results)
                        self.photoList.onNext(value)
                    } catch {
                        print("error")
                    }
                }
            case .failure(let error):
                
                print(error.errorDescription!)
                
            }
        }
    }
    
    func paginationRequest(item: Int, query: String) {
        
        do {
            let value = try photoList.value()
            if item == value.results.count - 1 && value.results.count < value.total {
                requestSearchPhoto(query: query, page: (value.results.count / 10) + 1)
            }
        } catch {
            print("error")
        }
        
    }
    
    func addFolder(item: SearchResult, text: String) {
        if repository.fetchFolderFilter(text: text).isEmpty {
            
            let task = PhotoFolder(folderName: text)
            task.photoDetail.append(Photo(photoDescription: item.resultDescription ?? text, photoURL: item.links.downloadLocation, photoId: item.id))
            do {
                try repository.addRealm(item: task)
            } catch {
                print("error")
            }
            
        } else {
            
            guard let folder = repository.fetchFolderFilter(text: text).first else {return}
            let item = Photo(photoDescription: item.resultDescription ?? text, photoURL: item.links.downloadLocation, photoId: item.id)
            do {
                try repository.appendPhoto(folder: folder, item: item)
            } catch {
                print("error")
            }
        }
    }
    
}
