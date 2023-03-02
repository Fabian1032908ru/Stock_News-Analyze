//
//  Login_Page_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 27.02.23.
//

import UIKit
import FirebaseAuth

class Login_Page_ViewController: UIViewController {
    
    var scrollview_login_page: UIScrollView!
    
    let image_logo_name = "Logo_Icon_Black"
    var image_logo: UIImage!
    var imageview_logo: UIImageView!
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var forgotPasswordButton: UIButton!
    
    @objc func login_button_func() {
        
        print("LOGIN in progress")
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        // Get Auth instance
        
        // Attempt sign in
        
        // if failure present alert to vreate account
        
        // check sing in on app launch
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                // Show account creation
                strongSelf.showCreateAccout()
                return
            }
            
            print("Yoz are signed in")
            
            self!.present_Tabbar()
            
        })
        
    }
    
    func showCreateAccout() {
        
        print("SHOW CREATE ACCOUNT")
        
    }
    
    func present_Tabbar() {
        
        // Create the view controller that you want to present modally
        let modalViewController = Main_UITabBarControllerViewController()

        // Set the presentation style (optional)
        modalViewController.modalPresentationStyle = .overFullScreen

        // Set the transition style (optional)
        modalViewController.modalTransitionStyle = .coverVertical

        // Present the view controller modally
        present(modalViewController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color
        view.backgroundColor = .systemBackground
        
        // create scrollview
        scrollview_login_page = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollview_login_page.contentSize = CGSize(width: width, height: height*0.8)
        self.view.addSubview(scrollview_login_page)
        
        // create imageview with logo of ours show
        image_logo = UIImage(named: image_logo_name)
        imageview_logo = UIImageView(image: image_logo)
        imageview_logo.frame = CGRect(x: width/2, y: height/4, width: width/6, height: height/14)
        imageview_logo.contentMode = .scaleAspectFit
        imageview_logo.center = self.view.center
        scrollview_login_page.addSubview(imageview_logo)
        // Replace the imageview immediatly after centering it
        imageview_logo.frame = CGRect(x: imageview_logo.frame.minX, y: 0, width: imageview_logo.frame.width, height: imageview_logo.frame.height)
        
        // Create the email text field
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailTextField.textColor = .label
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.clearButtonMode = .whileEditing
        scrollview_login_page.addSubview(emailTextField)
        emailTextField.frame = CGRect(x: width*0.05, y: height*0.125, width: width*0.9, height: height*0.06)
        
        // Create the password text field
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordTextField.textColor = .label
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .whileEditing
        scrollview_login_page.addSubview(passwordTextField)
        passwordTextField.frame  = CGRect(x: width*0.05, y: height*0.21, width: width*0.9, height: height*0.06)
        
        // Create the login button
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(login_button_func), for: .touchUpInside)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 8
        // loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        scrollview_login_page.addSubview(loginButton)
        loginButton.frame = CGRect(x: width*0.05, y: height*0.295, width: width*0.9, height: height*0.06)
        
        // Create the forgot password button
        forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        // forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        scrollview_login_page.addSubview(forgotPasswordButton)
        forgotPasswordButton.center = view.center
        forgotPasswordButton.frame = loginButton.frame
        forgotPasswordButton.frame = CGRect(x: forgotPasswordButton.frame.minX, y: loginButton.frame.maxY + height*0.01, width: forgotPasswordButton.frame.width, height: forgotPasswordButton.frame.height*0.7)

        
        
        // Add a tap gesture recognizer to hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
}

