//
//  NewsArticleCell.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 18/01/21.
//

import UIKit

class NewsArticleCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var modelArticle: TopHeadlineArticle?{
        didSet{
            articleConfiguration()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func articleConfiguration(){
        title.text = modelArticle?.title
        date.text = modelArticle?.publishedAt?.components(separatedBy: "T")[0]
        if let urlImage = modelArticle?.urlToImage {
            let urlString = urlImage.replacingOccurrences(of: "////", with: "//")
            imgView.kf.setImage(with: URL(string: urlString))
        } else {
            imgView?.image = UIImage(named: "iconImage")
        }
    }

}
