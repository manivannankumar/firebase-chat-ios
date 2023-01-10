//
//  AllusercellTableViewCell.swift
//  Peoplz
//
//  Created by Netaxis on 27/12/22.
//

import UIKit

class AllusercellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Alluerprofile: UIImageView!
    @IBOutlet weak var Allusercellview: UIView!
    @IBOutlet weak var Allusername: UILabel!
    @IBOutlet weak var Alluserdes: UILabel!
    @IBOutlet weak var Allusercompany: UILabel!
    @IBOutlet weak var AlluserDOB: UILabel!
    @IBOutlet weak var Alluserlocation: UILabel!
    @IBOutlet weak var Allusermobilenumber: UILabel!
    @IBOutlet weak var chatbutton: UIButton!
    @IBOutlet weak var onlinestatus: UIImageView!
    @IBOutlet weak var clicktochatlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
