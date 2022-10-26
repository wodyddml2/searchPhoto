//
//  SearchPhotoViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchPhotoViewModel {
    
    var photoList = BehaviorRelay(value: SearchPhoto(total: 0, totalPages: 0, results: []))
    
    
    let repository = PhotoFolderRepositry()
    
}

extension SearchPhotoViewModel {
    
    func requestSearchPhoto(query: String, page: Int) {
        APIService.searchPhoto(query: query, page: page) { photo, statusCode, error in
            guard let photo = photo else {return}
            if page == 1 {
                self.photoList.accept(photo)
            } else {
                var value = self.photoList.value
                value.results.append(contentsOf: photo.results)
                self.photoList.accept(value)
            }
            
            
        }
    }
    
    func paginationRequest(item: Int, query: String) {
        if item == photoList.value.results.count - 1 && photoList.value.results.count < photoList.value.total {
            requestSearchPhoto(query: query, page: (photoList.value.results.count / 10) + 1)
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
            
            let folder = repository.fetchFolderFilter(text: text)[0]
            let item = Photo(photoDescription: item.resultDescription ?? text, photoURL: item.links.downloadLocation, photoId: item.id)
            do {
                try repository.appendPhoto(folder: folder, item: item)
            } catch {
                print("error")
            }
        }
    }
    
}
