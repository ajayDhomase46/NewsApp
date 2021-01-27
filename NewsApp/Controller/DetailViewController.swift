//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 27/01/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
  
    @IBOutlet weak var textView: UITextView!
    
    var article: TopHeadlineArticle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //will improve code quality in next release
        if let aut = article?.author,
           let desc = article?.descriptionField,
           let con = article?.content{
            textView.text = "\(aut) \n \(desc) \n \(con)"
        }
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = article?.title
        if let urlImage = article?.urlToImage {
            let urlString = urlImage.replacingOccurrences(of: "////", with: "//")
            imgView.kf.setImage(with: URL(string: urlString))
        } else {
            imgView?.image = UIImage(named: "iconImage")
        }
    }
    

    @objc func back(sender: UIBarButtonItem) {
            _ = navigationController?.popViewController(animated: true)
        }


}
