//
//  APICenter.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

// MARK: HTTPMethod
// GET, PUT, POST
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
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
        guard let baseUrl = URL(string: urlString) else { 
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: baseUrl) { (data, response, error) in
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
