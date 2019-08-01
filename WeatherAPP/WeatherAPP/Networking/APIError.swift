//
//  APIError.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case networkFailed
    case decodingFailed
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFailed:
            return "요청 실패입니다."
        case .networkFailed:
            return "통신에 실패했습니다."
        case.decodingFailed:
            return "디코딩에 실패했습니다."
        }
    }
}
