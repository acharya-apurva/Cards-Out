//
//  CardDetailsViewController.swift
//  CardsOut
//
//  Created by Apurva Acharya on 2022-06-21.
//

import UIKit

class CardDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIColorPickerViewControllerDelegate {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var titleTextField: UITextField!
    //@IBOutlet weak var tableFooter: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var tableHeader: UIView!
    @IBOutlet weak var editOutlet: UIBarButtonItem!
    @IBOutlet weak var addDescriptionOutlet: UIButton!
    @IBOutlet weak var descriptTextView: UITextView!
    @IBOutlet weak var descriptLabel: UILabel!
    
    var cardToDisplay: Card?
    var editMode: Bool = false
    
    var hasDescription: Bool = true
    var backgroundOrText: Bool = true
    var txtColor: UIColor?
    var bckColor: UIColor?
    
    var fieldNames: [String] = []
    var fieldValues: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "detailCell", bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: "detailCell")
        detailTableView.delegate = self
        detailTableView.dataSource = self
    
        //setting the title
        if let card = cardToDisplay {
            titleTextField.insertText(card.title)
            descriptTextView.insertText(card.descript)
            hasDescription = card.hasDescript
            txtColor = card.textColor
            bckColor = card.backgroundColor
        }
        else{
            txtColor = .black
            bckColor = .white
        }
        descriptTextView.backgroundColor = bckColor
        descriptTextView.layer.borderWidth = 1.0
        descriptTextView.layer.borderColor = txtColor?.cgColor
        detailTableView.backgroundColor = bckColor
        titleTextField.backgroundColor = bckColor
        tableHeader.backgroundColor = bckColor
        descriptionView.backgroundColor = bckColor
        //tableFooter.backgroundColor = .white
        
        descriptTextView.textColor = txtColor
        titleTextField.textColor = txtColor
        descriptLabel.textColor = txtColor
        
        detailTableView.layer.borderWidth = 3
        detailTableView.layer.borderColor = txtColor?.cgColor

        self.detailTableView.isEditing = !editMode
        editOutlet.title = editMode ? "Edit" : "Done"
       // tableFooter.isHidden = editMode
        descriptTextView.isUserInteractionEnabled = !editMode
        titleTextField.isUserInteractionEnabled = !editMode
        
        
        
        descriptionView.isHidden = !hasDescription
        if hasDescription {
            //TODO: update  remove description action
            //addDescriptionOutlet.setTitle("Remove and Delete Description", for: .normal)
            tableHeader.frame = CGRect(x: 0, y: 0, width: 414, height: 195)
        }
        else {
            //addDescriptionOutlet.setTitle("Add a Description", for: .normal)
            tableHeader.frame = CGRect(x: 0, y: 0, width: 414, height: 58)
        }
    }
    
    // Tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let card = cardToDisplay else {
            return fieldNames.count
        }
        return card.fieldNames.count
        //return fieldNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailCell
        if let card = cardToDisplay {
            cell.field1.text = card.fieldNames[indexPath.row]
            cell.field2.text = card.fieldValues[indexPath.row]
            cell.field1.textColor = txtColor
            cell.field2.textColor = txtColor
            cell.field1.backgroundColor = bckColor
            cell.field2.backgroundColor = bckColor
            cell.backgroundColor = bckColor
            cell.field1.layer.borderColor = txtColor?.cgColor
            cell.field2.layer.borderColor = txtColor?.cgColor
            cell.field1.isUserInteractionEnabled = !editMode
            cell.field2.isUserInteractionEnabled = !editMode
        }
        return cell
    }
    
    //in order to reorder the rows moving the values at the respective arrays
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if let card = cardToDisplay{
            let movedObjTemp1 = (card.fieldNames[sourceIndexPath.item])
            let movedObjTemp2 = (card.fieldValues[sourceIndexPath.item])
            card.fieldNames.remove(at: sourceIndexPath.item)
            card.fieldValues.remove(at: sourceIndexPath.item)
            card.fieldNames.insert(movedObjTemp1, at: destinationIndexPath.item)
            card.fieldValues.insert(movedObjTemp2, at: destinationIndexPath.item)
        }
        else {
            let movedObjTemp1 = (fieldNames[sourceIndexPath.item])
            let movedObjTemp2 = (fieldValues[sourceIndexPath.item])
            fieldNames.remove(at: sourceIndexPath.item)
            fieldValues.remove(at: sourceIndexPath.item)
            fieldNames.insert(movedObjTemp1, at: destinationIndexPath.item)
            fieldValues.insert(movedObjTemp2, at: destinationIndexPath.item)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        for subViewA in cell.subviews {
            print(subViewA.classForCoder.description())
            if (subViewA.classForCoder.description() == "UITableViewCellReorderControl") {
                subViewA.tintColor = .white
                break;
            }
        }
    }
    
    //function for deleting the cell. deletes the value from the array then deletes cell from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            if let card = cardToDisplay {
                card.fieldNames.remove(at: indexPath.item)
                card.fieldValues.remove(at: indexPath.item)
            }
            else {
                fieldNames.remove(at: indexPath.item)
                fieldValues.remove(at: indexPath.item)
            }
            detailTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        
        self.detailTableView.isEditing = editMode
        editMode.toggle()
        descriptTextView.isUserInteractionEnabled = !editMode
        titleTextField.isUserInteractionEnabled = !editMode
        
        sender.title = (self.detailTableView.isEditing) ? "Done":"Edit"
        //tableFooter.isHidden = editMode
        detailTableView.reloadData()

        
        if editMode {
            if let card = cardToDisplay {
                updateCard(card: card) //purano card ho bhani update gar natra naya card add gar
            } else {
                addNewCard()
            }
        }
    }

    //save
    //create new card with required info
    //create unique cardId everyting we add new card
    private func addNewCard(){
        var tmpfieldNames : [String] = []
        var tmpfieldValues : [String] = []
        for cell in detailTableView.visibleCells as! Array<detailCell>{
            tmpfieldNames.append(cell.field1.text!)
            tmpfieldValues.append(cell.field2.text!)
        }
        let cardid =  UUID().uuidString
        let card = Card(id: cardid, title: titleTextField.text!, fieldNames: tmpfieldNames, fieldValues: tmpfieldValues, edited: false, deleteTheCard: false, backgroundColor: bckColor!, textColor: txtColor!, descript: descriptTextView.text, hasDescript: hasDescription)
//        let alert = UIAlertController(title: "New Card", message: "Are you sure you want to delete this card?", preferredStyle: .alert)
        displayAlert(title: "Success", message: "Card Successfully Created")

        DataManager.addItem(card: card)
    }
    
    //update
    //takes the card to be updated and updates the info

    private func updateCard(card: Card) {
        card.title = titleTextField.text!
        card.descript = descriptTextView.text
        card.hasDescript = hasDescription
        card.backgroundColor = bckColor ?? .gray
        card.textColor = txtColor ?? .black
        
        var j = 0
        for cell in detailTableView.visibleCells as! Array<detailCell>{
            card.fieldNames[j] = cell.field1.text!
            card.fieldValues[j] = cell.field2.text!
            j = j+1
        }
        DataManager.updateItem(card: card)
    }
    
 
    @IBAction func clickedAddAField(_ sender: UIButton) {
     
        if let card = cardToDisplay {
            fieldNames = card.fieldNames
            fieldValues = card.fieldValues

            card.fieldNames.append("")
            card.fieldValues.append("")
        }
        else{
            fieldNames.append("")
            fieldValues.append("")
        }
        detailTableView.reloadData()
    }
    
    @IBAction func clickedAddDescription(_ sender: UIButton) {
        hasDescription.toggle()
        descriptionView.isHidden = !hasDescription
        if hasDescription {
            //addDescriptionOutlet.setTitle("Remove and Delete Description", for: .normal)
            tableHeader.frame = CGRect(x: 0, y: 0, width: 414, height: 195)
        }
        else {
            //addDescriptionOutlet.setTitle("Add a Description", for: .normal)
            descriptTextView.text = ""
            detailTableView.sectionHeaderHeight = 0
            //tableHeader.frame = CGRect(x: 0, y: 0, width: 414, height: 58)
            //>>>>>>>>>>>>>>>>>>>>>
            
        }
        detailTableView.reloadData()
        
    }
    

    //next 2 methods for deleting a card
    @IBAction func clickedDeleteThisCard(_ sender: UIButton) {
        //generating an alert message before deleting the card
        let alert = UIAlertController(title: "Delete Card", message: "Are you sure you want to delete this card?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(alert: UIAlertAction!) in self.deleteCardButtonAction()})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //call this function when delete button is pressed in the UIAlertController
    func deleteCardButtonAction(){
        if let card = cardToDisplay{
            DataManager.deleteItem(card: card)
        }
        self.navigationController?.popViewController( animated: true)
    }
    
    
    
    //background and text color picking next 3 methods
    @IBAction func clickedChangeBackground(_ sender: UIButton) {
        backgroundOrText = true
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    @IBAction func clickedChangeText(_ sender: UIButton) {
        backgroundOrText = false
        let colorPicker = UIColorPickerViewController()
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        if backgroundOrText {
            bckColor = color
            descriptTextView.backgroundColor = bckColor
            detailTableView.backgroundColor = bckColor
            titleTextField.backgroundColor = bckColor
            //tableHeader.backgroundColor = bckColor
            descriptionView.backgroundColor = bckColor
        }
        else{
            txtColor = color
            descriptTextView.textColor = txtColor
            titleTextField.textColor = txtColor
            descriptLabel.textColor = txtColor
            detailTableView.layer.borderColor = txtColor?.cgColor
        }
        detailTableView.reloadData()
    }
    
    private func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true, completion: nil)
        }
    }


}
    

