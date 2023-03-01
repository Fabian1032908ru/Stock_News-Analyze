//
//  Test2_ViewController.swift
//  seasonalyze
//
//  Created by Fabian Stiewe on 01.03.23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class Test2_ViewController: UIViewController {

    let database = Firestore.firestore()
        
    var user_id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print(user_id!)
        
        view.backgroundColor = .systemGray6
        
        let docRef = database.document("userinfo/info")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            print(data)
        }
        
        writeData(text: "Just a test text")
        
        // Do any additional setup after loading the view.
    }
    
    func writeData(text: String) {
        
        let docRef = database.document("userinfo/infos")
        docRef.setData(["text" : text])
        
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
