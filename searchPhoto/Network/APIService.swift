//
//  APIService.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import Alamofire

enum Router: URLRequestConvertible {
    case get(query: String, page: Int)
    
    var baseURL: URL {
        return URL(string: APIKey.searchURL + path)!
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.authorization]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .get(let query, let page):
            return "\(query)&page=\(page)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        request.headers = header
        return request
    }
}

class APIService {
    
    static func searchPhoto(query: String, page: Int, completionHandler: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
        
        AF.request(Router.get(query: query, page: page)).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completionHandler(value, statusCode, nil)
            case .failure(let error): completionHandler(nil, statusCode, error)
            }
        }
    }

    private init() { }
}

// urlrequestconvertible : url, header 개선
// escaping closure -> Result Type
