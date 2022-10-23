//
//  PhotoRepository.swift
//  searchPhoto
//
//  Created by J on 2022/10/23.
//

import Foundation

import RealmSwift

protocol PhotoRepositoryType {
    func fetchFolder() -> Results<PhotoFolder>
    func fetchPhoto() -> Results<Photo>
    func addRealm(item: PhotoFolder) throws
}

class PhotoFolderRepositry: PhotoRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetchFolder() -> Results<PhotoFolder> {
        return localRealm.objects(PhotoFolder.self)
    }
    
    func fetchPhoto() -> Results<Photo> {
        return localRealm.objects(Photo.self)
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
