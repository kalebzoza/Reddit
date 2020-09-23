//
//  PostError.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

import Foundation

//error define file

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case thrownImageError(Error)
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        
        case .invalidURL:
            return " The sever failed to reach the necessary URL"
        case .thrownError(let error):
            return " There was an error \(error.localizedDescription)"
        case .noData:
            return "No data found "
        case .thrownImageError(let error):
            return "Could not display thumbNail image \(error.localizedDescription)"
        case .unableToDecode:
            return " There was an error decoding the data"
        }
    }
}
