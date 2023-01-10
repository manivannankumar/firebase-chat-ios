//
//  RegisterViewController.swift
//  Peoplz
//
//  Created by Netaxis on 26/12/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var peoplximage: UIImageView!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var haveaccountlabel: UILabel!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var emaillogo: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordlogo: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peoplximage.layer.cornerRadius = 15
        emailview.layer.cornerRadius = 15
        passwordview.layer.cornerRadius = 15
        registerbutton.layer.cornerRadius = 15
        loginbutton.layer.cornerRadius = 15
    }

    @IBAction func registeraction(_ sender: Any) {
        createUser(email: emailTF.text!, password: passwordTF.text!)
    }
    
    @IBAction func loginaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self](authResult, error) in
            if let user = authResult?.user {
                print(user.email!)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PeopledetailsViewController") as? PeopledetailsViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                self.emailTF.text = ""
                self.passwordTF.text = ""

            } else {
                let alert = UIAlertController(title: "Error", message: "This \(email) Already Exist", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
}
