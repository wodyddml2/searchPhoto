//
//  APIService.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import Foundation

import Alamofire

//enum APIError: Error {
//    case invalidHeaders
//}
//
//extension APIError: LocalizedError {
//    var errorDescription: String? {
//        switch self {
//        case .invalidHeaders:
//            return "검색 결과가 없습니다."
//        }
//    }
//}

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
    
    static func searchPhoto(query: String, page: Int, completionHandler: @escaping (Result<SearchPhoto, AFError>) -> Void) {
        
        AF.request(Router.get(query: query, page: page)).responseDecodable(of: SearchPhoto.self) { response in
    
            completionHandler(response.result)
        }
    }

    private init() { }
}

// urlrequestconvertible : url, header 개선
// escaping closure -> Result Type
