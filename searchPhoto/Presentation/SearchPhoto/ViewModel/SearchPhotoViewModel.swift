//
//  SearchPhotoViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

final class SearchPhotoViewModel {
    
    var photoList: Observable<SearchPhoto> = Observable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    let repository = PhotoFolderRepositry()
    
}

extension SearchPhotoViewModel {
    
    func requestSearchPhoto(query: String, page: Int) {
        APIService.searchPhoto(query: query, page: page) { photo, statusCode, error in
            guard let photo = photo else {return}
            self.photoList.value = photo
        }
    }
    
    func addFolder(item: SearchResult, text: String) {
        if repository.fetchFolderFilter(text: text).isEmpty {
            
            let task = PhotoFolder(folderName: text)
            task.photoDetail.append(Photo(photoDescription: item.resultDescription ?? text, photoURL: item.links.downloadLocation))
            do {
                try repository.addRealm(item: task)
            } catch {
                print("error")
            }
            
        } else {
            
            let folder = repository.fetchFolderFilter(text: text)[0]
            let item = Photo(photoDescription: item.resultDescription ?? text, photoURL: item.links.downloadLocation)
            do {
                try repository.appendPhoto(folder: folder, item: item)
            } catch {
                print("error")
            }
        }
    }
    
}
