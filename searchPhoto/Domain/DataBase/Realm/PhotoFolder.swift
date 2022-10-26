//
//  PhotoFolder.swift
//  searchPhoto
//
//  Created by J on 2022/10/23.
//

import Foundation

import RealmSwift

class PhotoFolder: Object{
    @Persisted var folderName: String
    @Persisted var photoDetail: List<Photo>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(folderName: String) {
        self.init()
        self.folderName = folderName
    }
}
