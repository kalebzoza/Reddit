//
//  PostController.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

//https://www.reddit.com/r/funny/.json ... the extension has a dot before it
import Foundation
//need to import UIKit for image
import UIKit.UIImage

//StringConstants struct is safer to use so there isnt any misspelling and to use within the code
struct StringConstants {
    fileprivate static let baseURL = "https://www.reddit.com"
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
        //data task
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            //first handle error
            if let error  = error {
                //need to complete with postError need to make a thrownError in postError
                return completion(.failure(.thrownError(error)))
            }
            //second check for data.. need to make noData in postError for completion
            guard let data =  data else {return completion(.failure(.noData)) }
            // need to do catch block to decode the data
            do {
                //need to fetch the TopLevelDictionary then work down
                //data is from the line above
                let topLevelDictionary =  try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                // need to get the data from the topLevelDictionary check the model to see what the data is called in the topLevelDictionary
                let secondLevelDictionary = topLevelDictionary.data
                //need to get the data again from secondLevelDictionary check the model to see what the data is called in the struct!
                let thirdLevelObjects =  secondLevelDictionary.children
                
                var postPlaceHolderArray:[Post] = []
                // for in loop to pool out the data
                for object in thirdLevelObjects {
                    //going to grab the data from thirdLevelObject/Post to append to postPlaceHolderArray
                    let post = object.data
                    postPlaceHolderArray.append(post)
                }
                //then return completion successful
                completion(.success(postPlaceHolderArray))
            }catch { //this gives a free Error
                //this will be a thrownError
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }//end of fetchPost
    
    // need function for image in the class
    static func fetchThumbnailFor(post: Post, completion: @escaping (Result<UIImage,PostError>) -> Void) {
        //need to get the url
        guard let url = post.thumbnail else {return completion(.failure(.invalidURL)) }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            //need to handle error
            if let error = error {
                //need a new error for image
                return completion(.failure(.thrownImageError(error)))
            }
            //need to check for data
            guard let data = data else { return completion(.failure(.noData)) }
            //need to check for image from data & need error if image cant decode to image
            guard let thumbnailImage = UIImage(data: data) else {return completion(.failure(.unableToDecode)) }
            //bring in thumbnailImage
            completion(.success(thumbnailImage))
            
            //dont need a do catch block cause the data is already decoded from the fetchPost function and non of the methods "throw" doesnt need to be in a do catch method
        }.resume()
    }
    
    
    
    
}//end of class


