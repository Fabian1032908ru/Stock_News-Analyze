//
//  Settings_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 28.02.23.
//

import UIKit
import FirebaseFirestore

class Settings_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
                
        let profileButton = ProfileButton(image: UIImage(named: "Logo_Icon_Black"), name: "John Doe")
        view.addSubview(profileButton)
        profileButton.frame = CGRect(x: 0, y: height*0.125, width: width, height: height*0.075)
        profileButton.backgroundColor = .systemGray6
        
        let borderWidth = CGFloat(1.0)
        
        let border = CALayer()
        border.borderColor = UIColor.systemGray5.cgColor
        border.frame = CGRect(x: 10, y: 0, width: profileButton.frame.size.width - 20, height: borderWidth)
        border.borderWidth = borderWidth
        profileButton.layer.addSublayer(border)

        let border2 = CALayer()
        border2.borderColor = UIColor.systemGray5.cgColor
        border2.frame = CGRect(x: 10, y: profileButton.frame.size.height - borderWidth, width: profileButton.frame.size.width - 20, height: borderWidth)
        border2.borderWidth = borderWidth
        profileButton.layer.addSublayer(border2)
        
    }
    
}


// Creates an nice uibutton as profil
class ProfileButton: UIButton {
    
    // MARK: - Properties
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    // MARK: - Initializers
    
    init(image: UIImage?, name: String) {
        super.init(frame: .zero)
        
        profileImageView.image = image
        nameLabel.text = name
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20.0),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

