//
//  PhotoListViewModel.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import RealmSwift

final class PhotoFolderViewModel {
    var folder: Observable<[PhotoFolder]> = Observable([PhotoFolder]())
    
    let repository = PhotoFolderRepositry()
   
}

extension PhotoFolderViewModel {
    func fetchFolder() {
        let task = Array(repository.fetchFolder())
        
        folder.value.append(contentsOf: task)
    }
}
