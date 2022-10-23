//
//  Unsplash.swift
//  searchPhoto
//
//  Created by J on 2022/10/23.
//

import Foundation

import RealmSwift

class Photo: Object {
    @Persisted var photoDescription: String
    @Persisted var photoURL: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(photoDescription: String, photoURL: String) {
        self.init()
        self.photoDescription = photoDescription
        self.photoURL = photoURL
    }
}
