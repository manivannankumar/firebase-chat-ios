//
//  ChatViewController.swift
//  Peoplz
//
//  Created by Netaxis on 31/12/22.
//

import UIKit
import FirebaseAuth
import SDWebImage


class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var safeareaview: UIView!
    @IBOutlet weak var chatersview: UIView!
    @IBOutlet weak var chaterprofile: UIImageView!
    @IBOutlet weak var chatername: UILabel!
    @IBOutlet weak var chaterstatus: UILabel!
    @IBOutlet weak var messagetableview: UITableView!
    @IBOutlet weak var messagesendview: UIView!
    @IBOutlet weak var sendmessageTF: UITextField!
    @IBOutlet weak var sendbutton: UIButton!
    
    
    var onetoone = [All_message]()
    
    var person_id : String  = ""
    var sendername : String = ""
    var senderimage : String = ""
    var receviername : String = ""
    var recevierimage : String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagetableview.dataSource = self
        messagetableview.delegate = self
        sendmessageTF.layer.cornerRadius = 15
        messagetableview.register(UINib(nibName: "senderTableViewCell", bundle: nil), forCellReuseIdentifier: "senderTableViewCell")
        messagetableview.register(UINib(nibName: "reciverTableViewCell", bundle: nil), forCellReuseIdentifier: "reciverTableViewCell")
        let authid = Auth.auth().currentUser?.uid
        dataforlogin(authids: authid ?? "")
        chaterprofile.layer.cornerRadius = chaterprofile.frame.width/2
        
        onetoone = [All_message]()
        All_Message_data()
        recevierdetails(authids: person_id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onlinestattus(status: "true")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataforlogin(authids: person_id)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onlinestattus(status: "false")
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func messagesendaction(_ sender: Any) {
        sendmessage()
        sendmessageTF.text = ""
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onetoone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(onetoone[indexPath.row].from == "sender"){
            let cell : senderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "senderTableViewCell") as! senderTableViewCell
            if onetoone.count != 0 {
                cell.sendermessage.text = "\(onetoone[indexPath.row].message)"
                cell.sendername.text = "\(sendername)"
                let url = "\(senderimage)"
                cell.senderimage.sd_setImage(with: NSURL(string: url ) as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
                
                cell.senderimage.layer.cornerRadius = cell.senderimage.frame.width/2
                
            }
            return cell
        } else {
            let cell : reciverTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reciverTableViewCell") as! reciverTableViewCell
            cell.receviermessgae.text = "\(onetoone[indexPath.row].message)"
            cell.receviername.text = "\(receviername)"
            let url = "\(recevierimage)"
            cell.reciverimage.sd_setImage(with: NSURL(string: url ) as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
            cell.reciverimage.layer.cornerRadius = cell.reciverimage.frame.width/2
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func dataforlogin(authids: String){
        dataref.child("AllUsers").child(authids).observe( .value, with: { snapshot in
              print(snapshot.value.self as Any)
            if let login_id = snapshot.value as? NSDictionary {
                let data_id = login_id.value(forKey: "Peoplz_key") as? String
                let data_name = login_id.value(forKey: "name") as? String
                let data_status = login_id.value(forKey: "status") as? String
                let data_image = login_id.value(forKey: "Proileimage") as? String
                self.chatername.text = data_name
                self.chaterprofile.sd_setImage(with: NSURL(string: data_image ?? "") as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
                if(data_status == "false"){
                    self.chaterstatus.textColor = UIColor.red
                    self.chaterstatus.text = "Offline"
                } else if(data_status == "true") {
                    self.chaterstatus.textColor = UIColor.systemGreen
                    self.chaterstatus.text = "Online"
                }
                print(data_id ?? "")
                print(data_name ?? "")
                print(data_status ?? "")
                self.sendername = data_name ?? ""
                self.senderimage = data_image ?? ""
              }}
        )
    }
    
    func recevierdetails(authids: String){
        dataref.child("AllUsers").child(authids).observe( .value, with: { snapshot in
              print(snapshot.value.self as Any)
            if let login_id = snapshot.value as? NSDictionary {
                let data_id = login_id.value(forKey: "Peoplz_key") as? String
                let data_name = login_id.value(forKey: "name") as? String
                let data_status = login_id.value(forKey: "status") as? String
                let data_image = login_id.value(forKey: "Proileimage") as? String
//                self.chatername.text = data_name
//                self.chaterprofile.sd_setImage(with: NSURL(string: data_image ?? "") as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
//                if(data_status == "false"){
//                    self.chaterstatus.textColor = UIColor.red
//                    self.chaterstatus.text = "Offline"
//                } else if(data_status == "true") {
//                    self.chaterstatus.textColor = UIColor.systemGreen
//                    self.chaterstatus.text = "Online"
//                }
                print(data_id ?? "")
                print(data_name ?? "")
                print(data_status ?? "")
                self.receviername = data_name ?? ""
                self.recevierimage = data_image ?? ""
              }}
        )
    }
    
    func sendmessage() {
        let authid = Auth.auth().currentUser?.uid
        let message_id = dataref.child("AllMessages/\(authid!)/\(self.person_id)/").childByAutoId().key
        dataref.child("AllMessages/\(authid ?? "")/\(self.person_id)/\(message_id ?? "")").setValue([
            "message_key" : "\(message_id ?? "")",
            "message" : "\(sendmessageTF.text ?? "")",
            "from" : "sender",
            "to" : "recevier"
        ]){
            error, _ in
            guard error == nil else {
                return print("error")
            }
        }
        dataref.child("AllMessages/\(self.person_id)/\(authid ?? "")/\(message_id ?? "")").setValue([
            "message_key" : "\(message_id ?? "")",
            "message" : "\(sendmessageTF.text ?? "")",
            "from" : "recevier",
            "to" : "sender"
        ]){
            error, _ in
            guard error == nil else {
                return print("error")
            }
        }
        
    }
    
    
    func All_Message_data() {
        
        
        let authid = Auth.auth().currentUser?.uid
        
        dataref.child("AllMessages").child(authid!).child(self.person_id).observe(.childAdded, with: { snapshot in
            if !snapshot.exists() { return }
            print("+++++=====++++++====)\(snapshot.value as Any)+++++=====++++++====)" )
            if let groups = snapshot.value as? NSDictionary {
                let message_key = groups.value(forKey: "message_key") as? String
                let messages = groups.value(forKey: "message") as? String
                let from = groups.value(forKey: "from") as? String
                let to = groups.value(forKey: "to") as? String
                let messagedata = All_message(from:"\(from ?? "")", to: "\(to ?? "")", message_id: "\(message_key ?? "")", message: "\(messages ?? "")")
                self.onetoone.append(messagedata)
                print(self.onetoone)
                self.messagetableview.reloadData()
            }
            
    

            print("////////////////////////////////////////////////////////////////")
        })
    }
    
}
