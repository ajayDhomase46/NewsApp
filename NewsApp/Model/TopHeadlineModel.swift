//
//  TopHeadlineModel.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 22/01/21.
//

import Foundation

struct TopHeadlineModel : Codable {

        let articles : [TopHeadlineArticle]?
        let status : String?
        let totalResults : Int?

        enum CodingKeys: String, CodingKey {
                case articles = "articles"
                case status = "status"
                case totalResults = "totalResults"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                articles = try values.decodeIfPresent([TopHeadlineArticle].self, forKey: .articles)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        }

}

struct TopHeadlineArticle : Codable {

        let author : String?
        let content : String?
        let descriptionField : String?
        let publishedAt : String?
        let source : TopHeadlineSource?
        let title : String?
        let url : String?
        let urlToImage : String?

        enum CodingKeys: String, CodingKey {
                case author = "author"
                case content = "content"
                case descriptionField = "description"
                case publishedAt = "publishedAt"
                case source = "source"
                case title = "title"
                case url = "url"
                case urlToImage = "urlToImage"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                author = try values.decodeIfPresent(String.self, forKey: .author)
                content = try values.decodeIfPresent(String.self, forKey: .content)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
                source = try TopHeadlineSource(from: decoder)
                title = try values.decodeIfPresent(String.self, forKey: .title)
                url = try values.decodeIfPresent(String.self, forKey: .url)
                urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
        }

}

struct TopHeadlineSource : Codable {

        let id : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
