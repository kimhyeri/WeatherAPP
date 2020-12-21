//
//  APICenter.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

// MARK: API KEY
let weatherAPIKey = "/weather API key/"

// MARK: HTTPMethod
// GET, PUT, POST, DELETE
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// MARK: HTTPHeader
// field, value
struct HTTPHeader {
    let field: String
    let value: String
}

// MARK: APICenter - perform sync, async
// 1. 동기,비동기 각각을 함수를 나누기 (직관적)
// 2. 동기,비동기 묶어서 하나의 함수로 만들기 (중복 제거)

struct APICenter {
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    
    private let session = URLSession.shared
    
    func perform(urlString: String,
                 request: APIRequest,
                 completion: @escaping APIClientCompletion) {
        guard let baseURL = URL(string: urlString) else { 
            completion(.failure(.invalidURL))
            return
        }
        
        var makeURLComponent = URLComponents()
        makeURLComponent.scheme = baseURL.scheme 
        makeURLComponent.host = baseURL.host 
        
        if let path = request.path {
            makeURLComponent.path = path             
        }
        
        let queryItems = request.queryItems?.map({
            URLQueryItem(name: $0.key, value: "\($0.value)")
        })
        makeURLComponent.queryItems = queryItems
        
        guard let requestURL = makeURLComponent.url else {
            completion(.failure(.invalidURL))
            return
        }
                
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, 
                                                   body: data)
                )
            )
        }
        task.resume()
    }
    
    func performSync(urlString: String,
                     request: APIRequest,
                     completion: @escaping APIClientCompletion) {
        guard let baseURL = URL(string: urlString) else { 
            completion(.failure(.invalidURL))
            return
        }
        
        var makeURLComponent = URLComponents()
        makeURLComponent.scheme = baseURL.scheme 
        makeURLComponent.host = baseURL.host 
        
        if let path = request.path {
            makeURLComponent.path = path 
        }
        
        let queryItems = request.queryItems?.map({
            URLQueryItem(name: $0.key, value: "\($0.value)")
        })
        makeURLComponent.queryItems = queryItems
        
        guard let requestURL = makeURLComponent.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)

        let task = session.dataTask(with: requestURL) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, 
                                                   body: data)
                )
            )
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}
