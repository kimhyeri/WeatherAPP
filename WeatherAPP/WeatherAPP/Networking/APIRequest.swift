//
//  APIRequest.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

class APIRequest {
    let method: HTTPMethod
    var path: String?
    var queryItems: [String: Any]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(method: HTTPMethod) {
        self.method = method
    }
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
    
    init(method: HTTPMethod, queryItems: [String: Any])  {
        self.method = method
        self.queryItems = queryItems
    }
    
    init(method: HTTPMethod, path: String, queryItems: [String: Any]) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
    }
    
    init<Body: Encodable>(method: HTTPMethod, path: String, body: Body) throws {
        self.method = method
        self.path = path
        self.body = try JSONEncoder().encode(body)
    }
}
