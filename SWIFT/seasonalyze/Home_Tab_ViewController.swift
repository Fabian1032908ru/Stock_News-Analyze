//
//  Home_Tab_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 28.02.23.
//

import UIKit

class Home_Tab_ViewController: UIViewController {

    var testbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.navigationController?.navigationBar.isHidden = false
        
        view.backgroundColor = .blue
        
        testbutton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        testbutton.backgroundColor = .red
        view.addSubview(testbutton)
        testbutton.addTarget(self, action: #selector(test_button_func), for: .touchUpInside)
        
    }
    
    @objc func test_button_func() {
         
        print("Test push try")
        
        let testPage = Test_ViewController()
        navigationController?.pushViewController(testPage, animated: true)

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
