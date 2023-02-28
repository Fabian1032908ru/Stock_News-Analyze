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
        
        let homeVC = Home_Tab_ViewController()
        homeVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(named: "house-icon"), tag: 0)
        
        let favoritesVC = Favourites_ViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "favorites-icon"), tag: 1)
        
        let settingsVC = Settings_ViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(named: "settings-icon"), tag: <#T##Int#>)
        
        viewControllers = [homeVC, favoritesVC, settingsVC]
        
    }
    
    
    
    
}
