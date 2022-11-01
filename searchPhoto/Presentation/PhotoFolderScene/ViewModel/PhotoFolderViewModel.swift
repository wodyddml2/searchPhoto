//
//  PhotoListViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import RealmSwift
import RxSwift

final class PhotoFolderViewModel {
    var folder = BehaviorSubject<[PhotoFolder]>(value: [])

    let repository = PhotoFolderRepositry()
}

extension PhotoFolderViewModel {
    
    func fetchFolder() {
        let task = Array(repository.fetch())
        
        folder.onNext(task)
    }
}
