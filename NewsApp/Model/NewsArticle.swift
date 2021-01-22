//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 18/01/21.
//

import Foundation
import ObjectMapper

class NewsArticle : Mappable{

    var articleTitle : String = ""
    var imageURL : String = ""
    var url : String = ""
    var articleDate : String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        articleTitle <- map["title"]
        imageURL <- map["urlToImage"]
        url <- map["url"]
        articleDate <- map["publishedAt"]
    }
}
