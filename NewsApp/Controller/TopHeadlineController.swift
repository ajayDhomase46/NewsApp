//
//  TopHeadlineViewController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 18/01/21.
//

import UIKit
import Kingfisher
import Alamofire
import SafariServices

class TopHeadlineController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var topHeadlineVM = TopHeadlineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topHeadlineVM.topHeadlineVC = self
        topHeadlineVM.fetchTopHeadline()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}

extension TopHeadlineController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topHeadlineVM.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NewsArticleCell
        let modelArticle = topHeadlineVM.articles[indexPath.row]
        cell.modelArticle = modelArticle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = topHeadlineVM.articles[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController
        vc?.article = article
        vc?.modalPresentationStyle = .fullScreen
        //self.navigationItem.title = "Back"
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}


extension TopHeadlineController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        topHeadlineVM.fetchSearchKeyword(searchBar.text)
    }
    
    
}
