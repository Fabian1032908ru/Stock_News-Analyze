//
//  Register_Page_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 27.02.23.
//

// Segue ID --> Register_Modal

import UIKit
import Firebase
import FirebaseFirestore

class Register_Page_ViewController: UIViewController {
    
    var test: UIView!
    
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
        
        // Get Info when keyboard is expanding
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        // Get Info when keyboard is expanding
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHides),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
        
        // create scrollview
        scrollview_register_page = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollview_register_page.contentSize = CGSize(width: width, height: height*0.85)
        self.view.addSubview(scrollview_register_page)
        
        test = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height*0.9))
        scrollview_register_page.addSubview(test)
        
        // Add a tap gesture recognizer to hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
        test.addGestureRecognizer(tapGesture)
        
        // create imageview with logo of ours show
        image_logo = UIImage(named: image_logo_name)
        imageview_logo = UIImageView(image: image_logo)
        imageview_logo.frame = CGRect(x: width/2, y: height/4, width: width/6, height: height/14)
        imageview_logo.contentMode = .scaleAspectFit
        imageview_logo.center = self.view.center
        scrollview_register_page.addSubview(imageview_logo)
        // Replace the imageview immediatly after centering it
        imageview_logo.frame = CGRect(x: imageview_logo.frame.minX, y: 0, width: imageview_logo.frame.width, height: imageview_logo.frame.height)
        
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
        emailTextField.frame = CGRect(x: width*0.05, y: height*0.125, width: width*0.9, height: height*0.06)
        emailTextField.textContentType = .emailAddress
        
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
        nameTextField.frame  = CGRect(x: width*0.05, y: height*0.21, width: width*0.9, height: height*0.06)
        nameTextField.textContentType = .name
        
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
        usernameTextField.frame = CGRect(x: width*0.05, y: height*0.295, width: width*0.9, height: height*0.06)
        usernameTextField.textContentType = .username
        
        // create birthdate picker
        birthDatePicker = UIDatePicker(frame: CGRect(x: width*0.05, y: height*0.38, width: width*0.9, height: height*0.06))
        birthDatePicker.datePickerMode = .date
        birthDatePicker.contentHorizontalAlignment = .left
        scrollview_register_page.addSubview(birthDatePicker)
        
        // Create the password text field
        passwordTextField = UITextField()
        // nameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordTextField.textColor = .label
        passwordTextField.autocapitalizationType = .allCharacters
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.keyboardType = .default
        passwordTextField.returnKeyType = .next
        passwordTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(passwordTextField)
        passwordTextField.frame  = CGRect(x: width*0.05, y: birthDatePicker.frame.maxY + height*0.025, width: width*0.9, height: height*0.06)
        
        // Irgendwann noch ein neues bild hinzufügen ...
        let visibilityButton = UIButton(type: .custom)
        let button_image = UIImage(named: "unhide_eye")
        let scaledImage = UIGraphicsImageRenderer(size: CGSize(width: passwordTextField.frame.height*0.7, height: passwordTextField.frame.height*0.7)).image { _ in
            button_image?.draw(in: CGRect(x: 0, y: 0, width: passwordTextField.frame.height*0.7, height: passwordTextField.frame.height*0.7))
        }
        visibilityButton.setImage(scaledImage, for: .normal)
        visibilityButton.contentMode = .scaleAspectFit
        visibilityButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        passwordTextField.rightView = visibilityButton
        passwordTextField.rightViewMode = .always
        
        // Create the confirm password text field
        confirmPasswordTextField = UITextField()
        // nameTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.placeholder = "Confrim Password"
        confirmPasswordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        confirmPasswordTextField.textColor = .label
        confirmPasswordTextField.autocapitalizationType = .allCharacters
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.keyboardType = .default
        confirmPasswordTextField.returnKeyType = .next
        confirmPasswordTextField.clearButtonMode = .whileEditing
        scrollview_register_page.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.frame  = CGRect(x: width*0.05, y: passwordTextField.frame.maxY + height*0.025, width: width*0.9, height: height*0.06)
        
        // Irgendwann noch ein neues bild hinzufügen ...
        let visibilityButton2 = UIButton(type: .custom)
        let button_image2 = UIImage(named: "unhide_eye")
        let scaledImage2 = UIGraphicsImageRenderer(size: CGSize(width: passwordTextField.frame.height*0.7, height: passwordTextField.frame.height*0.7)).image { _ in
            button_image2?.draw(in: CGRect(x: 0, y: 0, width: passwordTextField.frame.height*0.7, height: passwordTextField.frame.height*0.7))
        }
        visibilityButton2.setImage(scaledImage2, for: .normal)
        visibilityButton2.contentMode = .scaleAspectFit
        visibilityButton2.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        
        confirmPasswordTextField.rightView = visibilityButton2
        confirmPasswordTextField.rightViewMode = .always
        
        // Do not show the password, replace with dots
        passwordTextField.isSecureTextEntry = true
        // To be changed someday to newpassword
        passwordTextField.textContentType = .name
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.textContentType = .name
        
        
        register_button = UIButton()
        register_button.setTitle("Register", for: .normal)
        register_button.backgroundColor = .systemBlue
        // register_button.addTarget(self, action: #selector(register_button_func), for: .touchUpInside)
        register_button.addTarget(self, action: #selector(try_animation), for: .touchUpInside)
        scrollview_register_page.addSubview(register_button)
        register_button.frame = CGRect(x: width*0.05, y: confirmPasswordTextField.frame.maxY + height*0.025, width: width*0.9, height: height*0.06)
        register_button.layer.cornerRadius = register_button.frame.height/8
        register_button.clipsToBounds = true
        
    }
    
    @objc func try_animation() {
        
        imageview_logo.isHidden = true
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        
        let coverview = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        coverview.center = register_button.center
        coverview.backgroundColor = .systemBlue
        coverview.backgroundColor = .systemBackground
        view.addSubview(coverview)
        
        UILabel.animate(withDuration: 1, delay: 0.5, animations: {
            
            coverview.frame = CGRect(x: 0, y: 0, width: height*3, height: height)
            coverview.layer.cornerRadius = height/2
            coverview.clipsToBounds = true
            coverview.center = self.register_button.center
            coverview.backgroundColor = .systemBackground
            
        }, completion: { _ in
            
            // removed the animation because i want to try to do it again
            // was not as good as i wanted it to be
            
        })
        
    }
    
    @objc func togglePasswordVisibility() {
        
        passwordTextField.isSecureTextEntry.toggle()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            scrollview_register_page.contentSize = CGSize(width: width, height: height * 0.85 + keyboardHeight/2)
            
        }
        
    }
    
    @objc func keyboardHides() {
        
        UIScrollView.animate(withDuration: 0.4, animations: {
            self.scrollview_register_page.contentSize = CGSize(width: width, height: height * 0.85)
        })
        
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
