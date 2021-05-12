//
//  CheckListViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 14/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit
import EventKit
/// View Controller for Check List View
class CheckListViewController: UIViewController {
    
    /// Area outside the Check List View Modal
    @IBOutlet var outsideView: UIView!
    /// Modal view showing the Check List
    @IBOutlet var viewModal: UIView!
    
    /// Label showing the name of the check list
    @IBOutlet var titleLabel: UILabel!
    /// Button to set all list items as incomplete
    @IBOutlet var refreshButton: UIButton!
    /// Button to open the Reminders View to add List Reminders
    @IBOutlet var reminderButton: UIButton!
    
    /// Toolbar button to close the CheckList View
    @IBOutlet var closeButton: UIButton!
    /// Toolbar button to open the CheckList Settings Menu
    @IBOutlet var optionsButton: UIButton!
    /// Toolbar button to toggle the Check List between Locked and Editing Modes
    @IBOutlet var lockButton: UIButton!
    
    /// Table view showing list items
    @IBOutlet var listItemsTableView: UITableView!
    /// Text Field to create a New List Item
    @IBOutlet var newListItemInput: UITextField!
    
    /// Check List Model which the View Represents
    var currentCheckList: CheckListModel?
    /// Index of the View's checklist in Local Storage
    var currentCheckListIndex: Int?
    /// Boolean indicating if the view is in Editing Mode
    var listEditMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set up the List Items Table View
            - Set the Source of Data
            - Enable Drag and Drop Interactions
            - Style the sepearator between list items
         */
        listItemsTableView.delegate = self
        listItemsTableView.dataSource = self
        listItemsTableView.dragInteractionEnabled = true
        listItemsTableView.dragDelegate = self
        listItemsTableView.separatorColor = Theme.current.appAccentColor
        
        /* Load the Check List Data from the Local Storage */
        currentCheckList = LocalStorage.checkListModels[currentCheckListIndex!]
        
        /* Set up the toolbar text and buttons */
        titleLabel.makeCheckListCardTitle(title: currentCheckList!.title, maxLength: 20)
        closeButton.makeCheckListCardButton(icon: UIImage(named: "icon_cross")!)
        optionsButton.makeCheckListCardButton(icon: UIImage(named: "icon_options")!)
        /* Set the lock button icon based on the list editing mode */
        if(self.isEditing == false){
            lockButton.makeCheckListCardButton(icon: UIImage(named: "icon_locked")!)
        }else{
             lockButton.makeCheckListCardButton(icon: UIImage(named: "icon_unlocked")!)
        }
        
        /* Style the Check List View and its buttons */
        viewModal.makeCheckListCardView(checkList: currentCheckList!)
        refreshButton.makeCheckListTimeButton(title: "Refresh", icon: UIImage(named: "icon_refresh")!, color: Theme.current.greenColor)
        reminderButton.makeCheckListTimeButton(title: "Reminder", icon: UIImage(named: "icon_clock")!, color: Theme.current.redColor)
        newListItemInput.makeAddListItemTextInput(placeholder: "New Item...")
    }
    
    /// Closes the Check List View and returns to the Main View
    func closeCheckListView(){
        
        /* Reload the Main View to show changes made in the Check List View */
        if let firstVC = self.presentingViewController as? MainViewController {
           DispatchQueue.main.async {
               print("Dismissing Checklist View")
               firstVC.viewDidLoad()
               firstVC.checkListsTableView.reloadData()
           }
        }
        
        /* Close the Check List View */
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Handler Function for Check List Close Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.closeCheckListView()
    }
    
    /// Handler Function for Check List Lock Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func lockButtonPressed(_ sender: Any) {
        
        /* Switch the Editing Mode Boolean */
        if(self.isEditing == false){
            self.isEditing = true
        }else{
            self.isEditing = false
            
            /* Write changes to local storage when list is locked */
            LocalStorage.updateCheckListById(checkListId: currentCheckList!.id, updatedCheckList: currentCheckList!)
        }
        
        /* Reload the view to show the edits */
        self.viewDidLoad()
        self.listItemsTableView.reloadData()
    }
    
    /// Handler Function for Check List Options Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func optionsButtonPressed(_ sender: UIButton) {
        
        /* Prepare the Check List Settings Menu View */
        let storyboard = UIStoryboard(name: "CheckListSettings", bundle: nil)
        let checkListSettingsView = storyboard.instantiateInitialViewController() as! CheckListSettingsViewController
        
        /* Assign the current checklist to the settings menu to modify */
        checkListSettingsView.currentCheckList = self.currentCheckList
        
        /* Present the settings menu */
        self.present(checkListSettingsView, animated: true, completion: nil)
    }
    
    /// Handler function for Check List Refresh Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func refreshButtonPressed(_ sender: Any) {
        
        if let items = currentCheckList?.items{
            
            /* Set all list items to incomplete */
            for i in items.indices{
                currentCheckList!.items![i].completed = false
            }
        }
        
        /* Update Check List in Local Storage */
        LocalStorage.updateCheckListById(checkListId: currentCheckList!.id, updatedCheckList: currentCheckList!)
        
        /* Reload List Items to show changes */
        listItemsTableView.reloadData()
        
    }
    
    /// Handler Function for Check List Reminder Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func reminderButtonPressed(_ sender: UIButton) {
        
        /* Show the dialog to select reminders to add */
        self.showReminderPicker()
        
    }
    
    
    /// Handler function for New List Item Input Pressed
    /// - Parameter sender: Element Pressed
    @IBAction func newListItemInputPressed(_ sender: UITextField) {
       
        /* Prepare the Text Edit View */
        let nameEditStoryBoard = UIStoryboard(name: "TextEditView", bundle: nil)
        let textEditView = nameEditStoryBoard.instantiateInitialViewController() as! TextEditViewController

        /* Set function to use new input upon confirmation */
        textEditView.confirmFunction = {inputName in
           
            /* Create a new incomplete list item instance from the name provided */
            let newListItem = ListItemModel(title: inputName, completed: false)
                       
            /* Add New Item to Items list */
            if (self.currentCheckList?.items) != nil{
                self.currentCheckList?.items!.append(newListItem)
            }else{
                /* If items list doesn't exist, then create it first */
                self.currentCheckList?.items = [ListItemModel]()
                self.currentCheckList?.items!.append(newListItem)
            }

            /* Update the Check List in Local Storage */
            LocalStorage.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)

            /* Set text field value to empty */
            self.newListItemInput.text = ""

            /* Refresh List Items to show new item */
            self.listItemsTableView.reloadData()

            /* Scroll List to Bottom so that user can see new item*/
            DispatchQueue.main.async {
               let latestIndex = IndexPath(row: (self.currentCheckList?.items?.count)!-1, section: 0)
               self.listItemsTableView.scrollToRow(at: latestIndex, at: .bottom, animated: true)
            }
           
        }

        /* Present the Text Input view */
        self.present(textEditView, animated: true)
        /* Style the text field with color and placeholder */
        textEditView.prepareTextEditInput(color: Theme.getColorFromName(colorName: self.currentCheckList!.color), currentName: "", placeholder: "New Item")
    }
    
    
}
