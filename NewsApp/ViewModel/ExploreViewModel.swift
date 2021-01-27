//
//  ExploreViewModel.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 27/01/21.
//

import Foundation
import UIKit

class ExploreViewModel{
    
    weak var exploreVC: ExploreController?
    var sources = [ExploreSource]()
    var articles = [TopHeadlineArticle]()
    var sourcesID = [String]()
    
    func fetchSources(){
        Service.shared.fetchAllSources { (result) in
            switch result {
            case .success(let articles):
                self.sources.append(contentsOf: articles ?? [])
                self.exploreVC?.dropDown.optionArray = self.sources.map { (soure) in
                    soure.name ?? ""
                }
                self.sourcesID = self.sources.map { (soure) in
                    soure.id ?? ""
                }
                self.exploreVC?.dropDown.didSelect { (selectedText, index, id) in
                    self.fetchTopHeadline(index)
                }
                self.exploreVC?.dropDown.selectedIndex = 0
                self.exploreVC?.dropDown.text = self.exploreVC?.dropDown.optionArray[0]
                self.fetchTopHeadline(0)
            case .failure(let err):
                print("Failed to fetch articles:", err.localizedDescription)
                self.showAlert(err)
            }
        }
    }
    
    func fetchTopHeadline(_ index: Int){
        
        Service.shared.fetchTopHeadlines(self.sourcesID[index]) { (result) in
            switch result {
            case .success(let articles):
                self.articles.removeAll()
                self.articles.append(contentsOf: articles ?? [])
                DispatchQueue.main.async {
                    self.exploreVC?.tableView.reloadData()
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
        exploreVC?.present(alert, animated: true, completion: nil)
    }

}
