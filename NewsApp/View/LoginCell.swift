//
//  LoginCell.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 22/01/21.
//

import UIKit
import GoogleSignIn

class LoginCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "iconImage")
        return iv
    }()
    
    let textView: UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 32, left: 20, bottom: 0, right: 0)
        let attributedText = NSMutableAttributedString(string: "Sign in with \nGoogle", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.systemBlue])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let length = attributedText.string.count
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: _NSRange(location: 0, length: length))
        
        tv.attributedText = attributedText
        
        return tv
    }()
    
    let lineSeprateView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    let signInButton: UIView = {
        let button = GIDSignInButton()
        return button
    }()
    func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        //addSubview(lineSeprateView)
        addSubview(signInButton)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        //imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        textView.anchorToTop(nil, left: leftAnchor, bottom: signInButton.topAnchor, right: rightAnchor)
        //textView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true

//        lineSeprateView.anchorToTop(nil, left: leftAnchor, bottom: signInButton.topAnchor, right: rightAnchor)
//        lineSeprateView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        signInButton.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 30, bottomConstant: 100, rightConstant: 30)
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
