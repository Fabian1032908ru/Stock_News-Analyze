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
        
        // Delay animation around 4 seconds and then show login screen
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            UIImageView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: .curveLinear, animations: { [self] in
                
                imageview_logo.frame = CGRect(x: imageview_logo.frame.minX, y: height/8, width: imageview_logo.frame.width, height: imageview_logo.frame.height)
                
            })
            
        }
        
    }


}
