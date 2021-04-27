//
//  CheckListViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 14/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class CheckListViewController: UIViewController {

    @IBOutlet var outsideView: UIView!
    @IBOutlet var checkListViewModal: UIView!
    @IBOutlet var checkListTitleLabel: UILabel!
    @IBOutlet var checkListCloseButton: UIButton!
    @IBOutlet var checkListOptionsButton: UIButton!
    @IBOutlet var checkListLockButton: UIButton!
    @IBOutlet var listItemsTableView: UITableView!
    @IBOutlet var checkListRefreshButton: UIButton!
    @IBOutlet var newListItemInputBox: UITextField!
    @IBOutlet var newListItemAddButton: UIButton!
    
    var checkListIndex: Int?
    var currentCheckList: CheckListModel?
    var listEditMode: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        listItemsTableView.delegate = self
        listItemsTableView.dataSource = self
        
        currentCheckList = Data.checkListModels[checkListIndex!]
        
        checkListViewModal.makeCheckListCardView(checkList: currentCheckList!)
        
        checkListTitleLabel.makeCheckListCardTitle(title: currentCheckList!.title, maxLength: 25)
        checkListCloseButton.makeCheckListCardButton(icon: UIImage(named: "icon_cross")!)
        checkListOptionsButton.makeCheckListCardButton(icon: UIImage(named: "icon_options")!)
        
        if(self.isEditing == false){
            checkListLockButton.makeCheckListCardButton(icon: UIImage(named: "icon_locked")!)
        }else{
             checkListLockButton.makeCheckListCardButton(icon: UIImage(named: "icon_unlocked")!)
        }
        
        checkListRefreshButton.makeCheckListTimeButton(title: "Refresh", icon: UIImage(named: "icon_refresh")!, color: Theme.current.greenColor)
        
        
        newListItemAddButton.makeCheckListItemButton(icon: UIImage(named: "icon_plus")!, color: Theme.current.greenColor)
        
        newListItemInputBox.makeAddListItemTextInput(placeholder: "New Item...")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func refreshCheckListView(){
        self.listItemsTableView.reloadData()
    }
    
    @IBAction func checkListModalCloseButtonPressed(_ sender: Any) {
        
        //CheckListFunctions.updateCheckList(index: checkListIndex!, updatedCheckList: currentCheckList!)
        
        if let firstVC = self.presentingViewController as? MainViewController {
            DispatchQueue.main.async {
                print("Dismissing Checklist View")
                firstVC.viewDidLoad()
                firstVC.checkListsTableView.reloadData()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func checkListRefreshButtonPressed(_ sender: Any) {
        
        if let items = currentCheckList?.items{
            
            /* Set all list items to not completed */
            for i in items.indices{
            currentCheckList!.items![i].completed = false
            }
            
        }
        
        /* Save Updated Checklist */
        CheckListFunctions.updateCheckListById(checkListId: currentCheckList!.id, updatedCheckList: currentCheckList!)
        
        /* Refresh List Items */
        listItemsTableView.reloadData()
        
    }
    
    @IBAction func newListItemAddButtonPressed(_ sender: UIButton) {
        
        if(newListItemInputBox.text == ""){
            newListItemInputBox.invalidInput()
        }else{
            let newListItem = ListItemModel(title: newListItemInputBox.text!, completed: false)
            
            /* Add New Item to List */
            if (currentCheckList?.items) != nil{
                currentCheckList?.items!.append(newListItem)
            }
            
            /* Save Updated Checklist */
            CheckListFunctions.updateCheckListById(checkListId: currentCheckList!.id, updatedCheckList: currentCheckList!)
            
            newListItemInputBox.text = ""
            
            /* Refresh List Items */
            listItemsTableView.reloadData()
            
            /* Scroll List to Bottom so that user can see new item*/
            DispatchQueue.main.async {
                let latestIndex = IndexPath(row: (self.currentCheckList?.items?.count)!-1, section: 0)
                self.listItemsTableView.scrollToRow(at: latestIndex, at: .bottom, animated: true)
            }
                
        }
    }
    
    @IBAction func newListItemInputBoxTextChanged(_ sender: Any) {
        
        if(newListItemInputBox.text != ""){
            newListItemInputBox.clearInvalidInput()
        }
    }
    
    @IBAction func checkListLockButtonPressed(_ sender: Any) {
        
        if(self.isEditing == false){
            self.isEditing = true
        }else{
            self.isEditing = false
            /* Save Updated Checklist */
           CheckListFunctions.updateCheckListById(checkListId: currentCheckList!.id, updatedCheckList: currentCheckList!)
        }
        self.viewDidLoad()
        self.listItemsTableView.reloadData()
    }
    
    @IBAction func checkListOptionsButtonPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "CheckListSettings", bundle: nil)
        
        let checkListSettingsView = storyboard.instantiateInitialViewController() as! CheckListSettingsViewController
        
        checkListSettingsView.checkListId = self.currentCheckList!.id
        
        self.present(checkListSettingsView, animated: true, completion: nil)
        
    }
    
    
}
