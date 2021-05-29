//
//  CoreDataManger.swift
//  iOS Task
//
//  Created by mac on 5/29/21.
//

import Foundation

struct GitHupModel : Codable {
    var id : Int?
    var name : String?
    var owner : Owner?
    var description : String?
    var createdAt : String?
    var language : String?
    var forksCount : Int?
    var htmlURL: String?
   
    enum CodingKeys: String, CodingKey {
        case id , language , description , owner ,name
        case createdAt = "created_at"
        case forksCount = "forks_count"
        case htmlURL = "html_url"
    }
}

struct License : Codable {
    let key : String?
    let name : String?
    let spdx_id : String?
    let url : String?
    let node_id : String?
    
    enum CodingKeys: String, CodingKey {
        
        case key = "key"
        case name = "name"
        case spdx_id = "spdx_id"
        case url = "url"
        case node_id = "node_id"
    }
}

struct Owner : Codable {
    let avatarUrl : String?
    
    enum CodingKeys: String, CodingKey {
        
        case avatarUrl = "avatar_url"
        
    }
}
