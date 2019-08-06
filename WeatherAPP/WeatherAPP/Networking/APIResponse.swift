//
//  APIResponse.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

//MARK: APIResult
enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

//MARK: APIResponse
struct APIResponse<Body> {
    let statusCode: Int
    let body: Body
}

//MARK: APIResponse decode
extension APIResponse where Body == Data? {
    func decode<T: Decodable>(to type: T.Type) throws -> APIResponse<T> {
        guard let data = body else { 
            throw APIError.decodingFailed
        }
     
        let decodedJSON = try JSONDecoder().decode(T.self, from: data)

        return APIResponse<T>(statusCode: self.statusCode, body: decodedJSON)
    }
}
