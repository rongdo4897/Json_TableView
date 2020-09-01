//
//  Post.swift
//  PARSE_JSON_TABLE
//
//  Created by Hoang Tung Lam on 9/1/20.
//  Copyright © 2020 Hoang Tung Lam. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let data : [Post]
}

struct Post: Codable {
    var userName:String!
    var image:String!
    var location:String!
    var age:Int!
    var gender:String!
}
