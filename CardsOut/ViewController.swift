//
//  ViewController.swift
//  CardsOut
//
//  Created by Apurva Acharya  on 2022-06-21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    private var cardEntities = [CardEntity]()
    var userCards: [Card] = []
    var selectedCard: Card?
    //for search bar
    var searchingNames = [String()]
    var searching = false
    var searchCards: [Card] = []
 
    
    //context for using core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nib = UINib(nibName: "cardCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "cardCell")
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        searchBar.delegate = self
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 80
        mainTableView.separatorStyle = .none
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.alwaysBounceHorizontal = false
        
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
         // self.mainTableView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool){
        
        super.viewWillAppear(true)
        //getAllItems()
        userCards = DataManager.getAllItems()
        mainTableView.reloadData()

    }
    
//    //for the rounded corners with spacing in between
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if searching{
//            return searchCards.count
//        }
//        else{
//            return userCards.count
//        }
//    }
    
    //Functions for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchCards.count
        }
        else{
            return userCards.count
        }
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainCell = mainTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! cardCell

//        if searching {
//            mainCell.cardTitleLabel?.text = searchingNames[indexPath.row]
//        }
//        else {
//            mainCell.cardTitleLabel?.text = titles[indexPath.row]
//        }
        if searching {
            mainCell.cardTitleLabel.text = searchCards[indexPath.row].title
            mainCell.cardTitleLabel.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.cardTitleLabel.textColor = searchCards[indexPath.row].textColor
            mainCell.fldn1.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.fldn1.textColor = searchCards[indexPath.row].textColor
            mainCell.fldn2.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.fldn2.textColor = searchCards[indexPath.row].textColor
            mainCell.fldv1.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.fldv1.textColor = searchCards[indexPath.row].textColor
            mainCell.fldv2.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.fldv2.textColor = searchCards[indexPath.row].textColor
            mainCell.desLabel.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.desLabel.textColor = searchCards[indexPath.row].textColor
            mainCell.cardBackView.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.vMainStackView.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.field1StackView.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.field2StackView.backgroundColor = searchCards[indexPath.row].backgroundColor
            mainCell.descriptionStackView.backgroundColor = searchCards[indexPath.row].backgroundColor
            
            mainCell.field1StackView.isHidden = true
            mainCell.field2StackView.isHidden = true
            
            if searchCards[indexPath.row].fieldNames[0].isEmpty {
                mainCell.field1StackView.isHidden = true
            } else {
                mainCell.field1StackView.isHidden = false
                mainCell.fldn1.text = searchCards[indexPath.row].fieldNames[0]
                mainCell.fldv1.text = searchCards[indexPath.row].fieldValues[0]
            }
            if  searchCards[indexPath.row].fieldNames.count > 1 {
                if searchCards[indexPath.row].fieldNames[1].isEmpty {
                    mainCell.field2StackView.isHidden = true
                } else {
                    mainCell.field2StackView.isHidden = false
                    mainCell.fldn2.text = searchCards[indexPath.row].fieldNames[1]
                    mainCell.fldv2.text = searchCards[indexPath.row].fieldValues[1]
                }
            }
            if searchCards[indexPath.row].hasDescript {
                mainCell.descriptionStackView.isHidden = false
                mainCell.desLabel.text = searchCards[indexPath.row].descript
            } else {
                mainCell.descriptionStackView.isHidden = true
            }
        }
        else {
            mainCell.cardTitleLabel.text = userCards[indexPath.row].title
            mainCell.cardTitleLabel.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.cardTitleLabel.textColor = userCards[indexPath.row].textColor
            mainCell.fldn1.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.fldn1.textColor = userCards[indexPath.row].textColor
            mainCell.fldn2.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.fldn2.textColor = userCards[indexPath.row].textColor
            mainCell.fldv1.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.fldv1.textColor = userCards[indexPath.row].textColor
            mainCell.fldv2.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.fldv2.textColor = userCards[indexPath.row].textColor
            mainCell.desLabel.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.desLabel.textColor = userCards[indexPath.row].textColor
            mainCell.cardBackView.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.vMainStackView.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.field1StackView.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.field2StackView.backgroundColor = userCards[indexPath.row].backgroundColor
            mainCell.descriptionStackView.backgroundColor = userCards[indexPath.row].backgroundColor
            
            
            
            mainCell.field1StackView.isHidden = true
            mainCell.field2StackView.isHidden = true
            
            if userCards[indexPath.row].fieldNames.isEmpty {
                mainCell.field1StackView.isHidden = true
            } else {
                mainCell.field1StackView.isHidden = false
                mainCell.fldn1.text = userCards[indexPath.row].fieldNames[0]
                mainCell.fldv1.text = userCards[indexPath.row].fieldValues[0]
            }
            
            if  userCards[indexPath.row].fieldNames.count > 1 {
                if userCards[indexPath.row].fieldNames[1].isEmpty {
                    mainCell.field2StackView.isHidden = true
                } else {
                    mainCell.field2StackView.isHidden = false
                    mainCell.fldn2.text = userCards[indexPath.row].fieldNames[1]
                    mainCell.fldv2.text = userCards[indexPath.row].fieldValues[1]
                }
            }
            
            if userCards[indexPath.row].hasDescript {
                mainCell.descriptionStackView.isHidden = false
                mainCell.desLabel.text = userCards[indexPath.row].descript
            } else {
                mainCell.descriptionStackView.isHidden = true
            }
        }
        
       
        
        return mainCell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            selectedCard = searchCards[indexPath.row]
        }
        else{
            selectedCard = userCards[indexPath.row]
        }
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailsViewController") as! CardDetailsViewController
        detail.cardToDisplay = selectedCard
        detail.editMode = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailsViewController") as! CardDetailsViewController
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        var titles: [String] = []
        for i in 0...userCards.count-1{
            titles.append(userCards[i].title)
        }
        searchingNames = titles.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searchCards = userCards.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        mainTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searching = false
        searchBar.text = ""
        mainTableView.reloadData()
    }
}



