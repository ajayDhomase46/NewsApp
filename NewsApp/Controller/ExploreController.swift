//
//  ExploreViewController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 18/01/21.
//

import UIKit
import iOSDropDown

class ExploreController: UIViewController {

    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var tableView: UITableView!
    
    var exploreVM = ExploreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exploreVM.exploreVC = self
        exploreVM.fetchSources()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dropDown.endEditing(true)
    }
}

extension ExploreController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreVM.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NewsArticleCell
        let modelArticle = exploreVM.articles[indexPath.row]
        cell.modelArticle = modelArticle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = exploreVM.articles[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController
        vc?.article = article
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc!, animated: true)
        
    }
}
