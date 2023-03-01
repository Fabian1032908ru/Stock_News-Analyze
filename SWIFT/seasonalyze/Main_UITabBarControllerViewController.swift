//
//  Main_UITabBarControllerViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 28.02.23.
//

// Storyboard ID --> Main_Tabbar

import UIKit

class Main_UITabBarControllerViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        
        let homeVC = UINavigationController(rootViewController: Home_Tab_ViewController())
        homeVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(named: "hhhhouse-icon"), tag: 0)
        
        let favoritesVC = UINavigationController(rootViewController: Favourites_ViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "favorites-icon"), tag: 1)
        
        let settingsVC = UINavigationController(rootViewController: Settings_ViewController())
        settingsVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(named: "settings-icon"), tag: 2)
        
        viewControllers = [homeVC, favoritesVC, settingsVC]
        
    }
    
    
    
    
}
