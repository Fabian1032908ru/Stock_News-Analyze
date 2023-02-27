//
//  Register_Page_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 27.02.23.
//

import UIKit

class Register_Page_ViewController: UIViewController {
    
    var scrollview_register_page: UIScrollView!
    
    let image_logo_name = "Logo_Icon_Black"
    var image_logo: UIImage!
    var imageview_logo: UIImageView!
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var nameTextField: UITextField!
    let birthTextField = UITextField()
    var emailTextField: UITextField!
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let acceptGtcCheckbox = UISwitch()
    let acceptRiskEducationCheckbox = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color
        view.backgroundColor = .systemBackground
        
        // create scrollview
        scrollview_register_page = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollview_register_page.contentSize = CGSize(width: width, height: height*1.5)
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
        
        // Create the email text field
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
        
    }
    
    
}