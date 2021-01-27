//
//  TopHeadlineViewModel.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 26/01/21.
//

import Foundation
import UIKit

class TopHeadlineViewModel {
    
    weak var topHeadlineVC: TopHeadlineController?
    var articles = [TopHeadlineArticle]()
    
    func fetchTopHeadline(){
        
        Service.shared.fetchTopHeadlines(nil) { (result) in
            switch result {
            case .success(let articles):
                self.articles.removeAll()
                self.articles.append(contentsOf: articles ?? [])
                DispatchQueue.main.async {
                    self.topHeadlineVC?.tableView.reloadData()
                }
            case .failure(let err):
                print("Failed to fetch articles:", err.localizedDescription)
                self.showAlert(err)
            }
        }
    }
    
    func fetchSearchKeyword(_ keyword: String?){
        Service.shared.fetchSearchKeyword(keyword) { (result) in
            switch result {
            case .success(let articles):
                self.articles.removeAll()
                self.articles.append(contentsOf: articles ?? [])
                DispatchQueue.main.async {
                    self.topHeadlineVC?.tableView.reloadData()
                }
            case .failure(let err):
                print("Failed to fetch articles:", err.localizedDescription)
                self.showAlert(err)
            }
        }
    }
    func showAlert(_ error: Error) {
        let alert = UIAlertController(title: "Alert", message: String(format: "Failed to fetch articles: \(error.localizedDescription)"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topHeadlineVC?.present(alert, animated: true, completion: nil)
    }

}
