//
//  PeopledetailsViewController.swift
//  Peoplz
//
//  Created by Netaxis on 26/12/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

let dataref = Database.database().reference()
let storageRef = Storage.storage().reference()


class PeopledetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var peopledetailslabel: UILabel!
    @IBOutlet weak var peopleprofileimage: UIImageView!
    @IBOutlet weak var uploadimageicon: UIButton!
    @IBOutlet weak var usernameview: UIView!
    @IBOutlet weak var userlabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var companyview: UIView!
    @IBOutlet weak var complanylabel: UILabel!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var desview: UIView!
    @IBOutlet weak var deslabel: UILabel!
    @IBOutlet weak var desTF: UITextField!
    @IBOutlet weak var DOBview: UIView!
    @IBOutlet weak var DOBlabel: UILabel!
    @IBOutlet weak var DOBTF: UITextField!
    @IBOutlet weak var mobilemunview: UIView!
    @IBOutlet weak var mobilnumlabel: UILabel!
    @IBOutlet weak var mobilenumTF: UITextField!
    @IBOutlet weak var livedinview: UIView!
    @IBOutlet weak var livedinlabel: UILabel!
    @IBOutlet weak var livedinTF: UITextField!
    @IBOutlet weak var submitbutton: UIButton!
    
    var imagelink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleprofileimage.layer.cornerRadius = 15
        usernameview.layer.cornerRadius = 15
        companyview.layer.cornerRadius = 15
        desview.layer.cornerRadius = 15
        DOBview.layer.cornerRadius = 15
        mobilemunview.layer.cornerRadius = 15
        livedinview.layer.cornerRadius = 15
        submitbutton.layer.cornerRadius = 15
        
    }
    
    @IBAction func submitaction(_ sender: Any) {
        if(usernameTF.text != "" && companyTF.text != "" &&  desTF.text != ""  && DOBTF.text != "" && mobilenumTF.text != "" && livedinTF.text != "") {
            updateuserdetails(name: usernameTF.text!, company: companyTF.text!, desigination: desTF.text!, dateofbirth: DOBTF.text!, mobilenumber: mobilenumTF.text!, livedin: livedinTF.text!)
            onlinestattus(status: "false")
            print("currentuser \(Auth.auth().currentUser?.email as Any)")
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("firebaseAuth.signOut")
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                self.navigationController?.pushViewController(vc!, animated: true)
                let alert = UIAlertController(title: "Success", message: "\(usernameTF.text ?? "") Details successfully added  \n please LOGIN and join PEOPLZ ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } catch let signOutError as NSError {
                let alert = UIAlertController(title: signOutError as? String, message: "There is issue plz login later", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            print("currentuser \(Auth.auth().currentUser?.email as Any)")
        } else {
            let alert = UIAlertController(title: "Error", message: "Fill all the details", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateuserdetails(name: String, company: String, desigination : String, dateofbirth : String,  mobilenumber : String, livedin : String) {
        let authid = Auth.auth().currentUser?.uid
        dataref.child("AllUsers/\(authid!)").setValue([
            "name" : "\(name)",
            "company" : "\(company)",
            "desigination" : "\(desigination)",
            "dateofbirth" : "\(dateofbirth)",
            "mobilenumber" : "\(mobilenumber)",
            "livedin" : "\(livedin)",
            "Peoplz_key" : authid!,
            "Proileimage" : self.imagelink,
            "status" : "true"
        ]){
            error, _ in
            guard error == nil else {
                return print("error")
            }
            
        }
        
    }
    
    @IBAction func uploadimage(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            print(editedimage)
            self.imageurlget(data: editedimage.jpegData(compressionQuality: 0.5)!)
            self.peopleprofileimage.image = editedimage
            picker.dismiss(animated: true)
        } else if let originalimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(originalimage)
            self.imageurlget(data: originalimage.jpegData(compressionQuality: 0.5)!)
            self.peopleprofileimage.image = originalimage
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
                self.imagelink = "\(downloadURL)"
                print(downloadURL)
                print(self.imagelink)// Prints the URL to the newly uploaded data.
            }
            }
        print(uploadTask)
        }
    }

