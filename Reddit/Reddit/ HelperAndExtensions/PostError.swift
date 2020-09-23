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
}
