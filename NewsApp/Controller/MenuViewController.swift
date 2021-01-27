//
//  MenuViewController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 28/01/21.
//

import UIKit
import Kingfisher
import GoogleSignIn

protocol MenuControllerDelegate {
    func switchTabBar(_ index: Int)
}
class MenuViewController: UIViewController {
    
    var imgURL: URL?
    var userName: String?
    var delegate: MenuControllerDelegate?
    
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
   
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupMenuUI()
    }

    fileprivate func setupMenuUI()
    {
        self.mainBackgroundView.layer.cornerRadius = 40
        self.mainBackgroundView.clipsToBounds = true
        self.lblProfileName.text = userName
        self.profilePictureImage.layer.cornerRadius = 40
        self.profilePictureImage.clipsToBounds = true
        if let url = imgURL{
            self.profilePictureImage.kf.setImage(with: url)
        } else {
            self.profilePictureImage.image = UIImage(systemName: "person.crop.circle")
        }
    }
    
    @IBAction func topHeadlineTapped(_ sender: UIButton) {
        self.delegate?.switchTabBar(0)
    }
    @IBAction func exploreTapped(_ sender: UIButton) {
        self.delegate?.switchTabBar(1)
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.setUserData(nil, nil)
        UserDefaults.standard.synchronize()
        GIDSignIn.sharedInstance()?.signOut()
        let loginController = LoginViewController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {

    }
    
}
