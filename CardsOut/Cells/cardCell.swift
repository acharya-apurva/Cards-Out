//
//  cardCell.swift
//  CardsOut
//
//  Created by Apurva Acharya on 2022-08-18.
//

import UIKit

class cardCell: UITableViewCell {
    @IBOutlet var cardTitleLabel: UILabel!
    @IBOutlet var fldn1: UILabel!
    @IBOutlet var fldn2: UILabel!
    @IBOutlet var fldv1: UILabel!
    @IBOutlet var fldv2: UILabel!
    @IBOutlet var desLabel: UILabel!
    
    @IBOutlet weak var cardBackView: UIView!
    
    @IBOutlet weak var vMainStackView: UIStackView!
    
    @IBOutlet weak var field1StackView: UIStackView!
    
    
    @IBOutlet weak var field2StackView: UIStackView!
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBackView.layer.borderWidth = 1.0
        cardBackView.layer.borderColor = UIColor.lightGray.cgColor
        cardBackView.layer.cornerRadius = 10
//        backView.layer.borderWidth = 1.0
//        
//        //shadow settings
        cardBackView.layer.shadowColor = UIColor.black.cgColor
        cardBackView.layer.shadowOpacity = 1
        cardBackView.layer.shadowOffset = .zero
        cardBackView.layer.shadowRadius = 10
        
//        field1StackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10)

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
