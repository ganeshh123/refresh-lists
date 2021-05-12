//
//  MainViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View Controller for the Main Screen
class MainViewController: UIViewController {
    
    
    /// The main View of the App
    @IBOutlet var mainView: UIView!
    /// Title Label of the App's toolbar
    @IBOutlet var screenTitleLabel: UILabel!
    /// Button for App Settings
    @IBOutlet var appOptionsButton: UIButton!
    /// Button to Create a New List
    @IBOutlet var newListButton: UIButton!
    /// Table View of Check List Cards
    @IBOutlet var checkListsTableView: UITableView!
    
    /// Text to display on toolbar
    static var screenTitle = "Your Lists"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set Colors */
        mainView.backgroundColor = Theme.current.appBackgroundColor
        
        /* Setup Toolbar Text and Buttons */
        appOptionsButton.makeMainAppButton()
        newListButton.makeMainAppButton()
        screenTitleLabel.makeScreenTitleLabel(text: "Your Lists")
        
        /* Set Table's Data Source, and Enable Drag and Drop */
        checkListsTableView.dataSource = self
        checkListsTableView.delegate = self
        checkListsTableView.dragInteractionEnabled = true
        checkListsTableView.dragDelegate = self
        
        /* Read Check Lists from Local Storage and render in table */
        LocalStorage.readCheckLists { [unowned self] in
            self.checkListsTableView.reloadData()
        }
        
    }
    
    
    /// Handler for App Settings Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func appOptionsPressed(_ sender: UIButton) {
        
       /* Implemented in StoryBoard */
        
    }
    
    /// Handler for New List Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func newListButtonPressed(_ sender: UIButton) {
        
        /* Prepare a Text Edit Storyboard */
        let nameEditStoryBoard = UIStoryboard(name: "TextEditView", bundle: nil)
        let textEditView = nameEditStoryBoard.instantiateInitialViewController() as! TextEditViewController
        
        /* Set the confirmation function */
        textEditView.confirmFunction = {inputName in
            
            let checkListToAdd = CheckListModel(title: inputName, items: [])
            
            /* Create a New Checklist in Local Storage with the provided name */
            LocalStorage.newCheckList(checkListToAdd: checkListToAdd) { (createdCheckList: CheckListModel) in
                
                /* Reload Check Lists from Local Storage */
                LocalStorage.readCheckLists { [unowned self] in
                    self.checkListsTableView.reloadData()
                }
                
                /* Render Updated View to show New Check List */
                self.tableView(self.checkListsTableView, didSelectRowAt: [0, 0])
            }
        }
        
        textEditView.cancelFunction = {
            /* If Text Edit cancelled, then close the settings menu as well */
            self.dismiss(animated: true)
        }
        
        /* Present the Text Edit View, and prepare the Text Field */
        self.present(textEditView, animated: true)
        textEditView.prepareTextEditInput(color: Theme.getColorFromName(colorName: "sand"), currentName: "", placeholder: "New List Name")
        
    }
    
}
