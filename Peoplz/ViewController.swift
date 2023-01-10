//
//  ViewController.swift
//  Peoplz
//
//  Created by Netaxis on 26/12/22.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var peoplzimage: UIImageView!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var createacclabel: UILabel!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var emaillogo: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordlogo: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
    //   let authid = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peoplzimage.layer.cornerRadius = 15
        emailview.layer.cornerRadius = 15
        loginbutton.layer.cornerRadius = 15
        passwordview.layer.cornerRadius = 15
        registerbutton.layer.cornerRadius = 15
    }
    
    @IBAction func loginaction(_ sender: Any) {
        signIn(email: "\(emailTF.text!)", pass: "\(passwordTF.text!)")
    }
    
    
    @IBAction func registeraction(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func signIn(email: String, pass: String){
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                
                print(result?.user.uid ?? "")
                let authid = Auth.auth().currentUser?.uid
                print(authid ?? "")
                dataforlogin(authids: authid ?? "")
                self.emailTF.text = ""
                self.passwordTF.text = ""
            }
        }
        
        func dataforlogin(authids: String){
            
            dataref.child("AllUsers").child(authids).observeSingleEvent(of: .value, with: { snapshot in
                //  print(snapshot.value.self as Any)
                if let login_id = snapshot.value as? NSDictionary {
                    let data_id = login_id.value(forKey: "Peoplz_key") as? String
                    if(data_id == authids) {
                        self.logintohomepage()
                    }}}
            )
        }
    }
    
    func logintohomepage() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "myTabbar") as? UITabBarController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

