//
//  ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 26.02.23.
//

import UIKit
import FirebaseAuth

var height, width: CGFloat!

class LaunchPage: UIViewController {
    
    let image_logo_name = "Logo_Icon_Black"
    var image_logo: UIImage!
    var imageview_logo: UIImageView!
    
    let image_logo_word_name = "Logo_Word"
    var image_logo_word: UIImage!
    var imageview_logo_word: UIImageView!
    
    var register_button: UIButton!
    var login_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = self.view.frame.width
        height = self.view.frame.height
        
        LogOut()
        
        setup_interface()
        
    }
    
    @objc func LogOut() {
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
        }
        catch {
            print("error")
        }
        
    }
    
    @objc func login_button_func() {
        
        let login_page = Login_Page_ViewController()
        navigationController?.pushViewController(login_page, animated: true)
        
    }
    
    @objc func register_button_func() {
        
        let register_page = Register_Page_ViewController()
        navigationController?.pushViewController(register_page, animated: true)
        
    }
    
    func present_Tabbar() {
        
        // Create an instance of the new view controller you want to show
        let newViewController = Main_UITabBarControllerViewController()

        // Get the current navigation controller
        guard let navController = self.navigationController else { return }

        // Replace the current view controller stack with the new view controller
        navController.setViewControllers([newViewController], animated: true)

        
    }
    
    func setup_interface() {
        
        // create imageview with logo of ours show
        image_logo = UIImage(named: image_logo_name)
        imageview_logo = UIImageView(image: image_logo)
        imageview_logo.frame = CGRect(x: width/2, y: height/4, width: width/4, height: height/10)
        imageview_logo.contentMode = .scaleAspectFit
        imageview_logo.center = self.view.center
        self.view.addSubview(imageview_logo)
        
        // create imageview with logo of ours show
        image_logo_word = UIImage(named: image_logo_word_name)
        imageview_logo_word = UIImageView(image: image_logo_word)
        imageview_logo_word.frame = CGRect(x: width/2, y: height/4, width: width/2.5, height: height/10)
        imageview_logo_word.contentMode = .scaleAspectFit
        imageview_logo_word.center = self.view.center
        self.view.addSubview(imageview_logo_word)
        imageview_logo_word.alpha = 0
        
        // Create the register button
        register_button = UIButton(type: .system)
        register_button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        register_button.center = view.center
        register_button.setTitle("Register", for: .normal)
        register_button.setTitleColor(.white, for: .normal)
        register_button.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        register_button.layer.cornerRadius = 10
        register_button.addTarget(self, action: #selector(register_button_func), for: .touchUpInside)
        view.addSubview(register_button)
        
        // Create the login button
        login_button = UIButton(type: .system)
        login_button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        login_button.center = CGPoint(x: view.center.x, y: view.center.y + 70)
        login_button.setTitle("Login", for: .normal)
        login_button.setTitleColor(UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0), for: .normal)
        login_button.backgroundColor = .white
        login_button.layer.cornerRadius = 10
        login_button.layer.borderWidth = 1
        login_button.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor
        login_button.addTarget(self, action: #selector(login_button_func), for: .touchUpInside)
        view.addSubview(login_button)
        
        // Alpha 0 to animate buttons
        register_button.alpha = 0
        login_button.alpha = 0
        
        // Delay animation around 4 seconds and then show login screen
        let seconds = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [self] in
            
            UIImageView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: .curveLinear, animations: { [self] in
                
                // Placing Image on the top of the screen possible view
                imageview_logo.frame = CGRect(x: imageview_logo.frame.minX, y: height/8, width: imageview_logo.frame.width*0.8, height: imageview_logo.frame.height*0.8)
                imageview_logo.contentMode = .scaleAspectFit
                imageview_logo.center.x = view.center.x
                
            })
            
            // Incase the user is already signed in, we can skip some pages
            if FirebaseAuth.Auth.auth().currentUser != nil {
                
                imageview_logo_word.frame = CGRect(x: imageview_logo_word.frame.minX, y: imageview_logo.frame.minY + height/15, width: imageview_logo_word.frame.width, height: imageview_logo_word.frame.height)
                // Duration 0.5 delay 1
                UIImageView.animate(withDuration: 0.0, delay: 0, animations: { [self] in
                    imageview_logo_word.alpha = 1
                })
                
                // wait 2.5
                let seconds = 0.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {[self] in
                    
                    present_Tabbar()
                    
                })
                
            }
            else {
                
                imageview_logo_word.frame = CGRect(x: imageview_logo_word.frame.minX, y: imageview_logo.frame.minY + height/15, width: imageview_logo_word.frame.width, height: imageview_logo_word.frame.height)
                
                UIButton.animate(withDuration: 0.5, delay: 0.7, animations: { [self] in
                    
                    register_button.alpha = 1
                    login_button.alpha = 1
                    imageview_logo_word.alpha = 1
                    
                })
                
            }
            
            
        }
        
        
        
    }
    
    
}
