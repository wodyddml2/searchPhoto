//
//  SearchPhotoViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

final class SearchPhotoViewModel {
    var photoList: Observable<SearchPhoto> = Observable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { photo, statusCode, error in
            guard let photo = photo else {return}
            self.photoList.value = photo
        }
    }
}
