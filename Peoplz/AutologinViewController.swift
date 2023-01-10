//
//  AutologinViewController.swift
//  Peoplz
//
//  Created by Netaxis on 29/12/22.
//

import UIKit
import FirebaseAuth

func onlinestattus(status : String) {
    let authid = Auth.auth().currentUser?.uid
    dataref.child("AllUsers/\(authid ?? "")").updateChildValues([
        "status" : status
    ]){ error, _ in
        
        print(error ?? "")
    }
}

class AutologinViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "myTabbar") as? UITabBarController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        if Auth.auth().currentUser == nil{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
