//
//  Post.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

import Foundation

//the first three structs are all in one going to the TopLevelDictionary since its layered
struct TopLevelDictionary: Decodable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Decodable { //this is in the TopLevelDictionary
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable { //this is in the SecondLevelDictionary
    let data: Post
}

//naming of the url titles.... this is in the ThirdLevelObject
struct Post: Decodable {
    let title: String
    let ups: Int
    let thumbnail: URL?
}
