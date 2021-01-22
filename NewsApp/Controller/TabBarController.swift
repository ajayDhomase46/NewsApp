//
//  TabBarController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 22/01/21.
//

import UIKit
import GoogleSignIn

class TabBarController: UITabBarController {

    var imgURL: URL?
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        if let url = imgURL{
            imageview.kf.setImage(with: url)
        } else {
            imageview.image = UIImage(systemName: "person.crop.circle")
        }
        imageview.contentMode = UIView.ContentMode.scaleAspectFit
        imageview.layer.cornerRadius = 20
        imageview.layer.masksToBounds = true
        containView.addSubview(imageview)
        let rightBarButton = UIBarButtonItem(customView: containView)
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        if let name = userName{
            navigationItem.title = name
        } else {
            navigationItem.title = "Welcome back!"
        }
        
    }
    
    
    @objc func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.setUserData(nil, nil)
        UserDefaults.standard.synchronize()
        GIDSignIn.sharedInstance()?.signOut()
        let loginController = LoginViewController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }
}
