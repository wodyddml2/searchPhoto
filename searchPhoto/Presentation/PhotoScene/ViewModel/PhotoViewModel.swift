//
//  PhotoViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/23.
//

import Foundation

import RealmSwift
import RxSwift

class PhotoViewModel {
    var photo = BehaviorSubject<[Photo]>(value: [])

    let repository = PhotoFolderRepositry()
    
    var folderName: String?
}

extension PhotoViewModel {
    func fetchPhoto() {
        guard let name = folderName else {return}
        let task = Array(repository.fetchFolderFilter(text: name)[0].photoDetail)
        
        photo.onNext(task)
    }
}
