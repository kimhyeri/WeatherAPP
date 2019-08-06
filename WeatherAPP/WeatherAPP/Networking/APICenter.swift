//
//  APICenter.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

let weatherAPIKey = "20aaa3701000f86f51903b62779c4986"

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

// MARK: APICenter
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
        makeURLComponent.scheme = baseURL.scheme // https
        makeURLComponent.host = baseURL.host // api.openweathermap.org
        
        guard let path = request.path else {
            completion(.failure(.invalidURL))
            return
        }
        
        makeURLComponent.path = path // /data/2.5/weather
        
        let queryItems = request.queryItems?.map({
            URLQueryItem(name: $0.key, value: "\($0.value)")
        })

        makeURLComponent.queryItems = queryItems

        guard let requestURL = makeURLComponent.url else {
            completion(.failure(.invalidURL))
            return
        }
            
        print(requestURL)
        
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, 
                                                   body: data))
            )
        }
        task.resume()
    }
}
