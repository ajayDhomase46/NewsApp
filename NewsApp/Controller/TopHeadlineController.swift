//
//  TopHeadlineViewController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 18/01/21.
//

import UIKit
import ObjectMapper
import Kingfisher
import Alamofire
import SafariServices

class TopHeadlineController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: Array<NewsArticle> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopHeadline()
    }
    
    func fetchTopHeadline(){
        let url = String("https://newsapi.org/v2/top-headlines?country=in&apiKey=e34125c3491c437eb56ba8f5ff3cab23")
        let params = ["sortBy" : "latest"]
        AF.request(url, method: .get, parameters: params).validate().responseJSON { response in
            if let json = response.value as? [String : Any]{
                if let articleArray = json["articles"] as? Array<[String : Any]>{
                    for articleData in articleArray{
                        guard let article = Mapper<NewsArticle>().map(JSON: articleData) else{ continue}
                        self.articles.append(article)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension TopHeadlineController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NewsArticleCell
        cell.title.text = article.articleTitle
        cell.date.text = article.articleDate.components(separatedBy: "T")[0]
        if let imgURL = URL(string: article.imageURL){
            cell.imgView.kf.setImage(with: imgURL)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        if let artURL = URL(string: article.url){
            //UIApplication.shared.openURL(artURL)
            let safariViewController = SFSafariViewController(url: artURL)
            safariViewController.delegate = self
            safariViewController.modalPresentationStyle = .fullScreen
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(safariViewController, animated: true)
        }
    }
    
}


extension TopHeadlineController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // pop safari view controller and display navigation bar again
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}
