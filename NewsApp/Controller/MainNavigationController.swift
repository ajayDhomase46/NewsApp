//
//  MainNavigationController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 22/01/21.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            //assume user is logged in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarIdentifier") as! TabBarController
            let userData = UserDefaults.standard.getUserData()
            tabbarVC.imgURL = userData.imgURL
            tabbarVC.userName = "Welcome back \(userData.userName ?? "")"
            tabbarVC.modalPresentationStyle = .fullScreen
            viewControllers = [tabbarVC]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: {
            //perhaps we'll do something here later
        })
    }
}

