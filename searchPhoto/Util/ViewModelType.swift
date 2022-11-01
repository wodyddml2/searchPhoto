//
//  ViewModelType.swift
//  searchPhoto
//
//  Created by J on 2022/11/01.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
