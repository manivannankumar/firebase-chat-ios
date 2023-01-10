//
//  AllpeoplzViewController.swift
//  Peoplz
//
//  Created by Netaxis on 27/12/22.
//

import UIKit
import FirebaseAuth
import SDWebImage

var alldata = [Peoplz_Details]()

class AllpeoplzViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelviewtitle: UIView!
    @IBOutlet weak var applogoimage: UIImageView!
    @IBOutlet weak var Allpeoplzlabel: UILabel!
    @IBOutlet weak var requestbutton: UIButton!
    @IBOutlet weak var Allusertableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Allusertableview.delegate = self
        Allusertableview.dataSource = self
        Allusertableview.register(UINib(nibName: "AllusercellTableViewCell", bundle: nil), forCellReuseIdentifier: "AllusercellTableViewCell")
        labelviewtitle.layer.cornerRadius = 15
        Allpeoplzlabel.layer.cornerRadius = 10
        applogoimage.layer.cornerRadius = applogoimage.frame.width/2
        Allusertableview.layer.cornerRadius = 10
        
    }

    override func viewDidAppear(_ animated: Bool) {
        onlinestattus(status: "true")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alldata = [Peoplz_Details]()
        getalldata()
        updataData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onlinestattus(status: "false")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alldata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllusercellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AllusercellTableViewCell") as! AllusercellTableViewCell
        cell.Alluerprofile.layer.cornerRadius = cell.Alluerprofile.frame.width/2
        if alldata.count != 0 {
            cell.Allusername.text = alldata[indexPath.row].name
            cell.Alluserdes.text = alldata[indexPath.row].desigination
            cell.Allusercompany.text = alldata[indexPath.row].company
            cell.AlluserDOB.text = alldata[indexPath.row].dateofbirth
            cell.Alluserlocation.text = alldata[indexPath.row].livedin
            cell.Allusermobilenumber.text = alldata[indexPath.row].mobilenumber
            
            if(alldata[indexPath.row].status == "false"){
                cell.onlinestatus.tintColor = .red
                cell.clicktochatlabel.textColor = UIColor.red
                cell.clicktochatlabel.text = "Don't Tap to Chat"
            } else if(alldata[indexPath.row].status == "true") {
                cell.onlinestatus.tintColor = .systemGreen
                cell.clicktochatlabel.textColor = UIColor.systemGreen
                cell.clicktochatlabel.text = "Tap here to Chat>>>"
            }
            cell.chatbutton.tag = indexPath.row
            cell.chatbutton.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
    
            
            let url = alldata[indexPath.row].Proileimage
            cell.Alluerprofile.sd_setImage(with: NSURL(string: url) as URL?, placeholderImage:UIImage(contentsOfFile:"person.fill"))
        }
        
        return cell
    }
    
    
    @objc func connected(sender: UIButton) {
        let buttonclick = sender.tag
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        vc?.person_id = alldata[buttonclick].pep_id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func logoutaction(_ sender: Any) {
        onlinestattus(status: "false")
        let firebaseAuth = Auth.auth()
        do {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getalldata() {
        print("////////////////////////////////////////////////////////////////")
      // let authid = Auth.auth().currentUser?.uid
        dataref.child("AllUsers").observe(.childAdded, with: { snapshot in
            if !snapshot.exists() { return }
            print(snapshot.key as Any)
            if let groups = snapshot.value as? NSDictionary {
                print(groups.value(forKey: "name")!)
                let id = groups.value(forKey: "Peoplz_key") as? String
                let name = groups.value(forKey: "name") as? String
                let company = groups.value(forKey: "company") as? String
                let DOB = groups.value(forKey: "dateofbirth") as? String
                let desigination = groups.value(forKey: "desigination") as? String
                let mobilenumber = groups.value(forKey: "mobilenumber") as? String
                let location = groups.value(forKey: "livedin") as? String
                let status_Peoplz = groups.value(forKey: "status") as? String
                let Proileimage = groups.value(forKey: "Proileimage") as? String
                print(id ?? "")
                let alldatalist = Peoplz_Details(pep_id: id ?? "", name: name ?? "", company: company  ?? "", desigination: desigination ?? "", dateofbirth: DOB ?? "", mobilenumber: mobilenumber ?? "", livedin: location ?? "", Proileimage: Proileimage ?? "", status: status_Peoplz ?? "")
        
                    alldata.append(alldatalist)
                
                self.Allusertableview.reloadData()
            }
            
            print("////////////////////////////////////////////////////////////////")
        })
    }
    
    func updataData() {
        dataref.child("AllUsers").observe(.childChanged, with: { snapshot in
            if !snapshot.exists() { return }
            if let groups = snapshot.value as? NSDictionary {
                print(groups.value(forKey: "name")!)
                let pep_id = groups.value(forKey: "Peoplz_key") as? String
                let name = groups.value(forKey: "name") as? String
                let company = groups.value(forKey: "company") as? String
                let DOB = groups.value(forKey: "dateofbirth") as? String
                let desigination = groups.value(forKey: "desigination") as? String
                let mobilenumber = groups.value(forKey: "mobilenumber") as? String
                let location = groups.value(forKey: "livedin") as? String
                let status_Peoplz = groups.value(forKey: "status") as? String
                let Proileimage = groups.value(forKey: "Proileimage") as? String
                let alldatalist = Peoplz_Details(pep_id: pep_id ?? "", name: name ?? "", company: company  ?? "", desigination: desigination ?? "", dateofbirth: DOB ?? "", mobilenumber: mobilenumber ?? "", livedin: location ?? "", Proileimage: Proileimage ?? "", status: status_Peoplz ?? "")
                let index = alldata.firstIndex(where: {$0.name == alldatalist.name})
                alldata[index ?? 0] = alldatalist
                self.Allusertableview.reloadData()
                print(alldata)
            }
        })
    }
}
