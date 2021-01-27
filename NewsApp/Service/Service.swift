//
//  Service.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 26/01/21.
//

import UIKit
import Alamofire

class Service {
    
    static let shared = Service()
    
    fileprivate let baseURl = "https://newsapi.org/v2/"
    fileprivate let apiKey = "3a3b82731be74364add5f47790d1718f"
    
    func fetchTopHeadlines(_ source: String?, completion: @escaping (Result<[TopHeadlineArticle]?, Error>) -> ()) {
        
        let urlString = String(baseURl + "top-headlines")
        
        guard let url = URL(string: urlString) else { return }
        
        let params = ["apiKey" : apiKey,
                      "sortBy" : "latest",
                      "sources" : source ?? "bbc-news"]
        
        AF.request(url, method: .get, parameters: params).validate().responseJSON { responseData in
            
            if let err = responseData.error{
                completion(.failure(err))
                return
            }
            guard let data = responseData.data else { return }
            do {
                let topHeadlineModel = try JSONDecoder().decode(TopHeadlineModel.self, from:data)
                let articles = topHeadlineModel.articles
                completion(.success(articles))
            } catch let jsonError{
                completion(.failure(jsonError))
            }
        }
    }
    
    func fetchAllSources(completion: @escaping (Result<[ExploreSource]?, Error>) -> ()) {
        
        let urlString = String(baseURl + "sources")
        
        guard let url = URL(string: urlString) else { return }
        
        let params = ["apiKey" : apiKey]
        
        AF.request(url, method: .get, parameters: params).validate().responseJSON { responseData in
            
            if let err = responseData.error{
                completion(.failure(err))
                return
            }
            guard let data = responseData.data else { return }
            do {
                let exploreModel = try JSONDecoder().decode(ExploreModel.self, from: data)
                let sources = exploreModel.sources
                completion(.success(sources))
            } catch let jsonError{
                completion(.failure(jsonError))
            }
        }
    }
    
    
    func fetchSearchKeyword(_ keyword: String?, completion: @escaping (Result<[TopHeadlineArticle]?, Error>) -> ()) {
        
        let urlString = String(baseURl + "everything")
        
        guard let url = URL(string: urlString) else { return }
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        let date = dateformat.string(from: yesterday)
        
        let params = ["apiKey" : apiKey,
                      "sortBy" : "latest",
                      "q" : keyword ?? "apple",
                      "from" : date]
        print(params)
        AF.request(url, method: .get, parameters: params).validate().responseJSON { responseData in
            
            if let err = responseData.error{
                completion(.failure(err))
                return
            }
            guard let data = responseData.data else { return }
            do {
                let topHeadlineModel = try JSONDecoder().decode(TopHeadlineModel.self, from:data)
                let articles = topHeadlineModel.articles
                completion(.success(articles))
            } catch let jsonError{
                completion(.failure(jsonError))
            }
        }
    }
    
}
