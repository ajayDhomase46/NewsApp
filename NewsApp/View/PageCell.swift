//
//  PageCell.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 22/01/21.
//

import UIKit

class PageCell: UICollectionViewCell{
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            imageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedString.Key.foregroundColor : color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: _NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let lineSeprateView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    let textView: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    func setupViews() {        
        addSubview(imageView)
        addSubview(lineSeprateView)
        addSubview(textView)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: lineSeprateView.topAnchor, right: rightAnchor)
        
        lineSeprateView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeprateView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
