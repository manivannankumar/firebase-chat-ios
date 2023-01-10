//
//  senderTableViewCell.swift
//  Peoplz
//
//  Created by Netaxis on 04/01/23.
//

import UIKit

class senderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sendername: UILabel!
    @IBOutlet weak var sendermessage: UILabel!
    @IBOutlet weak var senderimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
