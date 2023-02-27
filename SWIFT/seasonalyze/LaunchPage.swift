//
//  ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 26.02.23.
//

import UIKit

class LaunchPage: UIViewController {
    
    var height, width: CGFloat!
    
    let image_logo_name = "Logo_Icon_Black"
    var image_logo: UIImage!
    var imageview_logo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = self.view.frame.width
        height = self.view.frame.height
        
        setup_interface()
        
    }
    
    func setup_interface() {
        
        // create imageview with logo of ours show
        image_logo = UIImage(named: image_logo_name)
        imageview_logo = UIImageView(image: image_logo)
        imageview_logo.frame = CGRect(x: width/2, y: height/4, width: width/4, height: height/10)
        imageview_logo.contentMode = .scaleAspectFit
        imageview_logo.center = self.view.center
        self.view.addSubview(imageview_logo)
        
        // Create the first button
       let button1 = UIButton(type: .system)
       button1.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
       button1.center = view.center
       button1.setTitle("Register", for: .normal)
       button1.setTitleColor(.white, for: .normal)
       button1.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
       button1.layer.cornerRadius = 10
       view.addSubview(button1)
       
       // Create the second button
       let button2 = UIButton(type: .system)
       button2.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
       button2.center = CGPoint(x: view.center.x, y: view.center.y + 70)
       button2.setTitle("Login", for: .normal)
       button2.setTitleColor(UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0), for: .normal)
       button2.backgroundColor = .white
       button2.layer.cornerRadius = 10
       button2.layer.borderWidth = 1
       button2.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor
       view.addSubview(button2)
        
        // Alpha 0 to animate buttons
        button1.alpha = 0
        button2.alpha = 0
        
        // Delay animation around 4 seconds and then show login screen
        let seconds = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            UIImageView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: .curveLinear, animations: { [self] in
                
                // Placing Image on the top of the screen possible view
                imageview_logo.frame = CGRect(x: imageview_logo.frame.minX, y: height/8, width: imageview_logo.frame.width, height: imageview_logo.frame.height)
                
            })
            
            UIButton.animate(withDuration: 0.5, delay: 0.7, animations: {
                
                button1.alpha = 1
                button2.alpha = 1
                
            })
            
        }
        
        
        
    }


}
