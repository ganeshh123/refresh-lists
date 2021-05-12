//
//  CheckListSettingsController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 18/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View Controller for Check List Settings Menu
class CheckListSettingsViewController: UIViewController {
    
    /// Area Outside Checklist Settings Menu
    @IBOutlet var outsideView: UIView!
    /// Container for Checklist Settings Menu
    @IBOutlet var container: UIView!
    /// Stack View for Checklist Settings Buttons
    @IBOutlet var buttonStack: UIStackView!
    /// Button to Rename Checklist
    @IBOutlet var renameButton: UIButton!
    /// Button to Delete Checklist
    @IBOutlet var deleteButton: UIButton!
    /// Button to switch the Checklist's colors
    @IBOutlet var colorSwitchButton: UIButton!
    
    /// Check List being Modified
    var currentCheckList: CheckListModel?

    override func viewDidLoad() {
       super.viewDidLoad()
    
        /* Add a listener for outside view tapped */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.outsideViewTouched(sender:)))
        outsideView.isUserInteractionEnabled = true
        outsideView.addGestureRecognizer(tap)
       
        /* Setup Settings Menu and Buttons */
        container.makeModalView()
        renameButton.makeSettingsButton(title: "Rename", icon: UIImage(named: "icon_edit")!, color: Theme.current.greenColor)
        deleteButton.makeSettingsButton(title: "Delete", icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        colorSwitchButton.makeSettingsButton(title: "Color", icon: UIImage(named: "icon_color")!, color: Theme.current.appAccentColor)
        
    }
    
    /// Dismisses the view when tapping outside the menu
    /// - Parameter sender: Gesture
    @objc func outsideViewTouched(sender: UITapGestureRecognizer? = nil) {
       self.dismiss(animated: true)
    }
    
    /// Handler for Rename Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func checkListSettingsRenameButtonPressed(_ sender: UIButton) {
        
        /* Prepare a Text Edit View */
        let nameEditStoryBoard = UIStoryboard(name: "TextEditView", bundle: nil)
        let textEditView = nameEditStoryBoard.instantiateInitialViewController() as! TextEditViewController
        
        /* Set Confirmation Function to rename with input */
        textEditView.confirmFunction = {inputName in
            
            /* Set the Check List's new name */
            self.currentCheckList?.title = inputName
            
            /* Update the Check List in Local Storage */
            LocalStorage.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)
            
            DispatchQueue.main.async {
                
                /* Close the Settings Menu */
                self.dismiss(animated: true)
                
                /* Reload the Check List View to show the new name */
                if let checkListView = self.presentingViewController as? CheckListViewController {
                    checkListView.currentCheckList = LocalStorage.checkListModels[checkListView.currentCheckListIndex!]
                    checkListView.viewDidLoad()
                }
                
            }
        }
        
        /* Set Cancel Function */
        textEditView.cancelFunction = {
            
            /* Close settings menu if text input cancelled */
            self.dismiss(animated: true)
        }
        
        /* Present Text Edit View and prepare the Text Field */
        self.present(textEditView, animated: true)
        textEditView.prepareTextEditInput(color: Theme.getColorFromName(colorName: self.currentCheckList!.color), currentName: self.currentCheckList!.title)
        
    }
    
    /// Handler Function for Delete Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func checkListSettingsDeleteButtonPressed(_ sender: UIButton) {
        
        /* Prepare a Confirmation View */
        let confirmationStoryBoard = UIStoryboard(name: "ConfirmationView", bundle: nil)
        let confirmationView = confirmationStoryBoard.instantiateInitialViewController() as! ConfirmationViewController
        
        /* Set Function if Deletion Confirmed */
        confirmationView.confirmFunction = {
            
            let checkListIdToDelete = self.currentCheckList!.id
            
            /* Delete the Check List from Local Storage */
            LocalStorage.deleteCheckListById(checkListId: checkListIdToDelete) { (deletedCheckListIndex) in
                
                DispatchQueue.main.async {
                    
                    /* Close the Settings Menu */
                    self.dismiss(animated: true)
                    
                    /* Close the Check List View and return to
                        the main menu, since the Check List was deleted.
                     */
                    if let checkListView = self.presentingViewController as? CheckListViewController {
                        checkListView.closeCheckListView()

                    }
                    
                }
                
            }
            
        }
        
        confirmationView.cancelFunction = {
            /* If deletion cancelled, then close the settings menu */
            self.dismiss(animated: true)
        }
        
        /* Present the Confirmation Dialog before deletion */
        self.present(confirmationView, animated: true, completion: nil)
        
    }
    
    /// Handler for Color Switch Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func checkListSettingsColorSwitchButtonPressed(_ sender: UIButton) {
        
        /* Change the Check List's Color to another one */
        self.currentCheckList!.color = Theme.switchListColor(currentColorName: self.currentCheckList!.color)
        
        /* Update the Check List in Local Storage */
        LocalStorage.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)
        
        DispatchQueue.main.async {
            
            /* Reload Checklist View to show the new color */
            if let checkListView = self.presentingViewController as? CheckListViewController {
                checkListView.currentCheckList = LocalStorage.checkListModels[checkListView.currentCheckListIndex!]
                checkListView.viewDidLoad()
            }
            
        }
        
    }
    
    
}
