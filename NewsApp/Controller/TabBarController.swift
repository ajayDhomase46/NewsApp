//
//  TabBarController.swift
//  NewsApp
//
//  Created by Ajay Dhomase on 22/01/21.
//

import UIKit
import SideMenu

class TabBarController: UITabBarController, MenuControllerDelegate {

    var imgURL: URL?
    var userName: String?
    var menu: SideMenuNavigationController?
    
    lazy var menuBarbuttonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuBarButtonTapped))
    
    @objc
    func menuBarButtonTapped() {
        present(menu!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBarUI()
    }
    
    fileprivate func setUpTabBarUI(){
        navigationItem.setLeftBarButton(menuBarbuttonItem, animated: false)
        let vc = storyboard?.instantiateViewController(withIdentifier: "menuViewController") as? MenuViewController
        vc?.imgURL = imgURL
        vc?.userName = userName
        vc?.delegate = self
        menu = SideMenuNavigationController(rootViewController: vc!)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "News App"
    }
    
    func switchTabBar(_ index: Int) {
        dismiss(animated: true) {
            self.selectedIndex = index
        }
    }
}
