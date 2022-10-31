//
//  PhotoRepository.swift
//  searchPhoto
//
//  Created by J on 2022/10/23.
//

import Foundation

import RealmSwift

protocol PhotoRepositoryType {
    associatedtype ResultsType
    func fetch() -> ResultsType
}

class PhotoFolderRepositry: PhotoRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<PhotoFolder> {
        return localRealm.objects(PhotoFolder.self)
    }
    
    func fetchFolderFilter(text: String) -> Results<PhotoFolder> {
        return localRealm.objects(PhotoFolder.self).filter("folderName == %@", text)
    }
    
    func addRealm(item: PhotoFolder) throws {
        try localRealm.write {
            localRealm.add(item)
        }
    }
   
    func appendPhoto(folder: PhotoFolder, item: Photo) throws {
        try localRealm.write {
            folder.photoDetail.append(item)
        }
    }
}
// repository 분리
