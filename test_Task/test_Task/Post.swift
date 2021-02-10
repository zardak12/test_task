//
//  Post.swift
//  Test_Task
//
//  Created by Марк Шнейдерман on 09.02.2021.
//

import Foundation

struct Post:Codable{
    let albumId :Int
    let postid :Int
    let title :String
    let bigPhoto :String
    let smallPhoto :String
    
    enum CodingKeys:String,CodingKey{
        case  albumId
        case  postid = "id"
        case  title
        case  bigPhoto = "url"
        case  smallPhoto = "thumbnailUrl"
    }
    
}
