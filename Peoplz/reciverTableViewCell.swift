//
//  reciverTableViewCell.swift
//  Peoplz
//
//  Created by Netaxis on 04/01/23.
//

import UIKit

class reciverTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var receviermessgae: UILabel!
    @IBOutlet weak var reciverimage: UIImageView!
    @IBOutlet weak var receviername: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
