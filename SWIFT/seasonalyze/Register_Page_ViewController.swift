//
//  Register_Page_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 27.02.23.
//

// Segue ID --> Register_Modal

import UIKit
import Firebase

class Register_Page_ViewController: UIViewController {
    
    let database = Firestore.firestore()
    
    var scrollview_register_page: UIScrollView!
    
    let image_logo_name = "Logo_Icon_Black"
    var image_logo: UIImage!
    var imageview_logo: UIImageView!
    
    let scrollView = UIScrollView()
    var nameTextField: UITextField!
    var usernameTextField: UITextField!
    var birthDatePicker: UIDatePicker!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmPasswordTextField: UITextField!
    var acceptGtcCheckbox = UISwitch()
    let acceptRiskEducationCheckbox = UISwitch()
    
    var register_button: UIButton!
    
    var user_id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color
        view.backgroundColor = .systemBackground
        
        // Add a tap gesture recognizer to hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // create scrollview
        scrollview_register_page = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollview_register_page.contentSize = CGSize(width: width, height: height)
        self.view.addSubview(scrollview_register_page)
        
        // create imageview with logo of ours show
        image_logo = UIImage(named: image_logo_name)
        imageview_logo = UIImageView(image: image_logo)
        imageview_logo.frame = CGRect(x: width/2, y: height/4, width: width/6, height: height/14)
        imageview_logo.contentMode = .scaleAspectFit
        imageview_logo.center = self.view.center
        scrollview_register_page.addSubview(imageview_logo)
        // Replace the imageview immediatly after centering it
        imageview_logo.frame = CGRect(x: imageview_logo.frame.minX, y: height/30, width: imageview_logo.frame.width, height: imageview_logo.frame.height)
        
        // Create the email text field
        emailTextField = UITextField()
        // emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailTextField.textColor = .label
        emailTextField.autocapitalizationType = .none
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(emailTextField)
        emailTextField.frame = CGRect(x: width*0.05, y: height*0.175, width: width*0.9, height: height*0.06)
        
        // Create the name text field
        nameTextField = UITextField()
        // nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameTextField.textColor = .label
        nameTextField.autocapitalizationType = .none
        nameTextField.borderStyle = .roundedRect
        nameTextField.keyboardType = .default
        nameTextField.returnKeyType = .next
        nameTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(nameTextField)
        nameTextField.frame  = CGRect(x: width*0.05, y: height*0.26, width: width*0.9, height: height*0.06)
        
        // Create the username text field
        usernameTextField = UITextField()
        // nameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        usernameTextField.textColor = .label
        usernameTextField.autocapitalizationType = .none
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.keyboardType = .default
        usernameTextField.returnKeyType = .next
        usernameTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(usernameTextField)
        usernameTextField.frame  = CGRect(x: width*0.05, y: height*0.345, width: width*0.9, height: height*0.06)
        
        // create birthdate picker
        birthDatePicker = UIDatePicker(frame: CGRect(x: width*0.05, y: height*0.43, width: width*0.9, height: height*0.06))
        birthDatePicker.datePickerMode = .date
        birthDatePicker.contentHorizontalAlignment = .left
        scrollview_register_page.addSubview(birthDatePicker)
        
        // Create the password text field
        passwordTextField = UITextField()
        // nameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordTextField.textColor = .label
        passwordTextField.autocapitalizationType = .none
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.keyboardType = .default
        passwordTextField.returnKeyType = .next
        passwordTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(passwordTextField)
        passwordTextField.frame  = CGRect(x: width*0.05, y: birthDatePicker.frame.maxY + height*0.025, width: width*0.9, height: height*0.06)
        
        // Create the confirm password text field
        confirmPasswordTextField = UITextField()
        // nameTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.placeholder = "Confrim Password"
        confirmPasswordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        confirmPasswordTextField.textColor = .label
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.keyboardType = .default
        confirmPasswordTextField.returnKeyType = .next
        confirmPasswordTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.frame  = CGRect(x: width*0.05, y: passwordTextField.frame.maxY + height*0.025, width: width*0.9, height: height*0.06)
        
        // Do not show the password, replace with dots
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        register_button = UIButton()
        register_button.setTitle("Register", for: .normal)
        register_button.backgroundColor = .systemBlue
        register_button.addTarget(self, action: #selector(register_button_func), for: .touchUpInside)
        scrollview_register_page.addSubview(register_button)
        register_button.frame = CGRect(x: width*0.05, y: confirmPasswordTextField.frame.maxY + height*0.025, width: width*0.9, height: height*0.06)
        register_button.layer.cornerRadius = register_button.frame.height/8
        register_button.clipsToBounds = true
        
    }
    
    @objc func register_button_func() {
        
        let mail = emailTextField.text!
        let name = nameTextField.text!
        let username = usernameTextField.text!
        let birthdate = birthDatePicker.date
        let password = passwordTextField.text!
        let con_password = confirmPasswordTextField.text!
        let accept_gtc = true
        let accept_risk = true
        
        print(mail, name, username, birthdate, password)
        
        if password == con_password {
            
            FirebaseAuth.Auth.auth().createUser(withEmail: mail, password: password, completion: { [weak self] result, error in
                
                guard let _ = self else {
                    return
                }
                guard error == nil else {
                    print("Account creation failed")
                    return
                }
                
                self!.user_id = Auth.auth().currentUser?.uid
                
                let docRef = self!.database.document("userinfo/\(self!.user_id!)")
                docRef.setData(["name": name, "username": username, "birthdate": birthdate, "mail": mail, "GTC": accept_gtc, "Risk": accept_risk])
                
                print(self!.user_id!)
                
                
                
                self!.present_Tabbar()
                
            })
            
        }
        else {
            
        }
        
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
    
}

enum CustomError: Error {
    
    case somethingWentWrong
    case anotherError(reason: String)
    
}
