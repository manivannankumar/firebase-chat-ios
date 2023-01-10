//
//  PeopleprofileViewController.swift
//  Peoplz
//
//  Created by Netaxis on 27/12/22.
//

import UIKit
import FirebaseAuth
import SDWebImage

class PeopleprofileViewController: UIViewController {
    
    @IBOutlet weak var editprofile: UIImageView!
    @IBOutlet weak var editprofilelabel: UILabel!
    @IBOutlet weak var editdelailview: UIView!
    @IBOutlet weak var editdeslabel: UILabel!
    @IBOutlet weak var editdoblabel: UILabel!
    @IBOutlet weak var editcompanylabel: UILabel!
    @IBOutlet weak var editloaction: UILabel!
    @IBOutlet weak var editbutton: UIButton!
    @IBOutlet weak var safeareaview: UIView!
    @IBOutlet weak var editphonenumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editprofile.layer.cornerRadius = editprofile.frame.width/2
        editdelailview.layer.cornerRadius = 15
        editdelailview.layer.borderWidth = 0.5
        editprofilelabel.layer.cornerRadius = 15
        editprofilelabel.layer.borderWidth = 0.5
        editprofilelabel.clipsToBounds = true
        editphonenumber.layer.cornerRadius = 15
        editphonenumber.layer.borderWidth = 0.5
        editphonenumber.clipsToBounds = true
        editbutton.layer.cornerRadius = 15
        editbutton.layer.borderWidth = 0.5
        editdeslabel.layer.cornerRadius = 15
        editdeslabel.clipsToBounds = true
        editdeslabel.layer.borderWidth = 0.5
        editdoblabel.layer.cornerRadius = 15
        editdoblabel.clipsToBounds = true
        editcompanylabel.layer.borderWidth = 0.5
        editcompanylabel.layer.cornerRadius = 15
        editcompanylabel.clipsToBounds = true
        editloaction.layer.borderWidth = 0.5
        editloaction.layer.cornerRadius = 15
        editloaction.clipsToBounds = true
        editdoblabel.layer.borderWidth = 0.5
        safeareaview.layer.cornerRadius = 15
        safeareaview.layer.borderWidth = 2.5
        safeareaview.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataforlogin()
        onlinestattus(status: "true")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onlinestattus(status: "false")
    }
    
    
    
    @IBAction func editbuttonaction(_ sender: Any) {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditdetailsViewController") as? EditdetailsViewController
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true, completion: nil)
    }
    
    
    func dataforlogin(){
        let authids = Auth.auth().currentUser?.uid
        dataref.child("AllUsers").child("\(authids ?? "")").observeSingleEvent(of: .value, with: { snapshot in
            if let login_id = snapshot.value as? NSDictionary {
                let data_id : String = login_id.value(forKey: "Peoplz_key") as? String ?? ""
                let data_name : String = login_id.value(forKey: "name") as? String ?? ""
                let data_des : String = login_id.value(forKey: "desigination") as? String ?? ""
                let data_dob : String = login_id.value(forKey: "dateofbirth") as? String ?? ""
                let data_company : String = login_id.value(forKey: "company") as? String ?? ""
                let data_location : String = login_id.value(forKey: "livedin") as? String ?? ""
                let data_number : String = login_id.value(forKey: "mobilenumber") as? String ?? ""
                let data_image : String = login_id.value(forKey: "Proileimage") as? String ?? ""
                
                self.editprofilelabel.text = data_name
                self.editdeslabel.text = data_des
                self.editdoblabel.text = data_dob
                self.editcompanylabel.text = data_company
                self.editloaction.text = data_location
                self.editphonenumber.text = data_number
                let url = data_image
                self.editprofile.sd_setImage(with: NSURL(string: url) as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
                
                print(data_id)
            }
        }
                                                                               
                                                                               
        )
    }
}
