//
//  EditdetailsViewController.swift
//  Peoplz
//
//  Created by Netaxis on 29/12/22.
//

import UIKit
import FirebaseAuth
import SDWebImage

class EditdetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var editpeopledetails: UILabel!
    @IBOutlet weak var edituploadimage: UIImageView!
    @IBOutlet weak var editimagebutton: UIButton!
    @IBOutlet weak var safeareaview: UIView!
    @IBOutlet weak var deslabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var submitupdatebutton: UIButton!
    @IBOutlet weak var livedinTF: UITextField!
    @IBOutlet weak var livedinlabel: UILabel!
    @IBOutlet weak var mobilenumTF: UITextField!
    @IBOutlet weak var mobilenumlabel: UILabel!
    @IBOutlet weak var doblabel: UILabel!
    @IBOutlet weak var desTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var companylabel: UILabel!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var editusernamelabel: UIView!
    @IBOutlet weak var Editcompanylabel: UIView!
    @IBOutlet weak var editdeslabel: UIView!
    @IBOutlet weak var editdob: UIView!
    @IBOutlet weak var editlovation: UIView!
    @IBOutlet weak var editmobilenumber: UIView!
    @IBOutlet weak var backbutton: UIButton!
    
    var editimagelink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edituploadimage.layer.cornerRadius = 15
        editusernamelabel.layer.cornerRadius = 15
        Editcompanylabel.layer.cornerRadius = 15
        editdeslabel.layer.cornerRadius = 15
        editdob.layer.cornerRadius = 15
        editmobilenumber.layer.cornerRadius = 15
        editlovation.layer.cornerRadius = 15
        submitupdatebutton.layer.cornerRadius = 1
        dataforlogin()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        onlinestattus(status: "true")
    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        onlinestattus(status: "false")
//    }
    
    @IBAction func bckaction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func editimageuploadaction(_ sender: Any) {
        let Alert = UIAlertController(title: "Choose Images", message: " Select images from media", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "Select from Gallery", style: .default) { UIAlertAction in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)
        }
        let Camera = UIAlertAction(title: "Select from Camera", style: .default) {_ in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .camera
            image.allowsEditing = true
            self.present(image, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        print("manivannan gallery picker")
        Alert.addAction(gallery)
        Alert.addAction(Camera)
        Alert.addAction(cancel)
        self.present(Alert, animated: true)
    }
    
    @IBAction func updateaction(_ sender: Any) {
        updateuserdetails(name: usernameTF.text ?? "" , company: companyTF.text ?? "" , desigination: desTF.text ?? "" , dateofbirth: dobTF.text ?? "" , mobilenumber: mobilenumTF.text ?? "", livedin: livedinTF.text ?? "")
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
                
                self.usernameTF.text = data_name
                self.desTF.text = data_des
                self.dobTF.text = data_dob
                self.companyTF.text = data_company
                self.livedinTF.text = data_location
                self.mobilenumTF.text = data_number
                let url = data_image
                self.edituploadimage.sd_setImage(with: NSURL(string: url) as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
                self.editimagelink = data_image
                
                print(data_id)
            }
        }
        )
    }
    
    func updateuserdetails(name: String, company: String, desigination : String, dateofbirth : String,  mobilenumber : String, livedin : String) {
        let authid = Auth.auth().currentUser?.uid
        dataref.child("AllUsers/\(authid!)").updateChildValues([
            "name" : "\(name)",
            "company" : "\(company)",
            "desigination" : "\(desigination)",
            "dateofbirth" : "\(dateofbirth)",
            "mobilenumber" : "\(mobilenumber)",
            "livedin" : "\(livedin)",
            "Peoplz_key" : authid!,
            "Proileimage" : self.editimagelink,
            "status" : "true"
        ]){
            error, _ in
            guard error == nil else {
                
                return print("error")
            }
            
        }
        self.dismiss(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            print(editedimage)
            self.imageurlget(data: editedimage.jpegData(compressionQuality: 0.5)!)
            self.edituploadimage.image = editedimage
            picker.dismiss(animated: true)
        } else if let originalimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(originalimage)
            self.imageurlget(data: originalimage.jpegData(compressionQuality: 0.5)!)
            self.edituploadimage.image = originalimage
            picker.dismiss(animated: true)
        } else {
            print("Error")
        }
    }
    
    func imageurlget(data: Data) {
     //   guard let info = data else { return }
        let authid = Auth.auth().currentUser!.uid
                let mountainsRef = storageRef.child("AllUsers/Profileimage/\(authid)/\(authid)Peoplz.png")
        let uploadTask = mountainsRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                return
            }
           
            let size = metadata.size
            print(size)
            mountainsRef.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                self.editimagelink = "\(downloadURL)"
                print(downloadURL)
                print(self.editimagelink)// Prints the URL to the newly uploaded data.
            }
            }
        print(uploadTask)
        }
    
}
