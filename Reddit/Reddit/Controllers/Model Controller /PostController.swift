//
//  PostController.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

//https://www.reddit.com/r/funny/.json ... the extension has a dot before it
import Foundation

//StringConstants struct is safer to use so there isnt any misspelling and to use within the code
struct StringConstants {
    fileprivate static let baseURL = "https://www.reddit.com/r/funny/.json"
    fileprivate static let rEndpoint = "r"
    fileprivate static let funnyEndpoint = "funny"
    fileprivate static let jsonExtension = "json"
}

class PostController {
    // dont need a singleton/SoT cause we are not updating data
    
    static func fetchPost(completion: @escaping (Result <[Post], PostError>) -> Void) {
        //this will be an URL Error for failure
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL)) }
        let rComponentURL = baseURL.appendingPathComponent(StringConstants.rEndpoint)
        let funnyComponentURL = rComponentURL.appendingPathComponent(StringConstants.funnyEndpoint)
        let finalURL = funnyComponentURL.appendingPathExtension(StringConstants.jsonExtension)
        //always print the final URL
        print(finalURL)
        
        
    }//end of fetchPost
    
}//end of class
