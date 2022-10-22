//
//  APIService.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import Alamofire

class APIService {
    static func searchPhoto(query: String, completionHandler: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completionHandler(value, statusCode, nil)
            case .failure(let error): completionHandler(nil, statusCode, error)
            }
        }
    }

    private init() { }
}
