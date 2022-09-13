//
//  DataManager.swift
//  CardsOut
//
//  Created by Apurva Acharya on 2022-07-29.
//
import UIKit
import Foundation

class DataManager {
    
    
    //context for using core data
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var cardEntities = [CardEntity]()
    
    static func getAllItems() ->[Card]  {
        var userCards: [Card] = []
        do {
            cardEntities = try context.fetch(CardEntity.fetchRequest())
        }
        catch {
            //error
        }
        if cardEntities.count != 0 {
            //for i in 0..<cardEntities.count{ //because it runs once when it is 0...0
            for i in stride(from: cardEntities.count-1, to: -1, by: -1){ //cause i want the latest card to come on top
                let tempCard = Card(id: cardEntities[i].id,
                                    title: cardEntities[i].title ?? "",
                                    fieldNames: cardEntities[i].fieldNames,
                                    fieldValues: cardEntities[i].fieldValues,
                                    edited: cardEntities[i].edited,
                                    deleteTheCard: cardEntities[i].deleteTheCard,
                                    backgroundColor: cardEntities[i].backgroundColor,
                                    textColor: cardEntities[i].textColor,
                                    descript: cardEntities[i].descript,
                                    hasDescript: cardEntities[i].hasDescript)
                userCards.append(tempCard)
                
            }
        }
        
        return userCards
        
    }
   
    static func addItem(card: Card) {
        //do add stuffs here
        let newItem = CardEntity(context: context)
        newItem.title = card.title
        newItem.id = UUID().uuidString
        newItem.fieldNames = card.fieldNames
        newItem.deleteTheCard = card.deleteTheCard
        newItem.edited = card.edited
        newItem.fieldValues = card.fieldValues
        newItem.backgroundColor = card.backgroundColor
        newItem.textColor = card.textColor
        newItem.descript = card.descript
        newItem.hasDescript = card.hasDescript
        do {
            try context.save()
        }
        catch {
        }
    }
    
    static func deleteItem(card: Card) {
        //delete card
        let tempEntities = cardEntities.filter {$0.id != card.id} //higher order function
        let item = cardEntities.filter {$0.title == card.title}.first
        context.delete(item!)
        cardEntities = tempEntities
        
        do {
            try context.save()
        }
        catch {
        }
    }
    
    static func updateItem(card: Card) {
        //updated card
        
        //card.edited = false
        for i in 0..<cardEntities.count{
            if cardEntities[i].id == card.id {
                cardEntities[i].title! = card.title
                cardEntities[i].fieldNames = card.fieldNames
                cardEntities[i].fieldValues = card.fieldValues
                cardEntities[i].edited = card.edited
                cardEntities[i].deleteTheCard = card.deleteTheCard
                cardEntities[i].backgroundColor = card.backgroundColor
                cardEntities[i].textColor = card.textColor
                cardEntities[i].descript = card.descript
                cardEntities[i].hasDescript = card.hasDescript
            }
        }
        do {
            try context.save()
        }
        catch {
        }
    }
}
