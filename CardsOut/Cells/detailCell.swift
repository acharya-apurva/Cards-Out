//
//  detailCell.swift
//  CardsOut
//
//  Created by Apurva Acharya on 2022-06-22.
//

import UIKit

class detailCell: UITableViewCell {
    @IBOutlet var field1 : UITextField!
    @IBOutlet var field2 : UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        field1.layer.borderWidth = 1.0
        field2.layer.borderWidth = 1.0
        
        accessoryView?.tintColor = .red
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
