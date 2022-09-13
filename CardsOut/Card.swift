//
//  File.swift
//  CardsOut
//
//  Created by Apurva Acharya on 2022-06-28.
//

import Foundation
import UIKit

class Card {
    static var idAssign: Int = 0
    //ekai chin id kai hatako
    var id: String
    var title: String
    var fieldNames: [String] = []
    var fieldValues: [String] = []
    var edited: Bool = false
    var deleteTheCard: Bool = false
    var backgroundColor: UIColor
    var textColor: UIColor
    var descript: String
    var hasDescript: Bool
    
    init(id:String = "",title: String = "Add a title", fieldNames: [String] = [], fieldValues: [String] = [], edited: Bool = false, deleteTheCard: Bool = false, backgroundColor: UIColor = .gray, textColor: UIColor = .black, descript: String = "", hasDescript: Bool = false){
        self.title = title
        self.fieldNames = fieldNames
        self.deleteTheCard = deleteTheCard
        self.edited = edited
        self.fieldValues = fieldValues
        self.id = id
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.descript = descript
        self.hasDescript = hasDescript
    }
    
    
    
}

//class UsersCards {
//    var cards: [Card]
    
//    init(cards: [Card]) {
//        self.cards = cards
//    }
//}
