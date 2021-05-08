//
//  CheckListSettingsController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 18/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class CheckListSettingsViewController: UIViewController {

    @IBOutlet var checkListSettingsOutsideView: UIView!
    @IBOutlet var checkListSettingsViewModal: UIView!
    @IBOutlet var checkListSettingsButtonStackView: UIStackView!
    @IBOutlet var checkListSettingsRenameButton: UIButton!
    @IBOutlet var checkListSettingsDeleteButton: UIButton!
    @IBOutlet var checkListSettingsColorSwitchButton: UIButton!
    
    var currentCheckList: CheckListModel?

    override func viewDidLoad() {
       super.viewDidLoad()

       // Do any additional setup after loading the view.
       
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.outsideViewTouched(sender:)))
       checkListSettingsOutsideView.isUserInteractionEnabled = true
       checkListSettingsOutsideView.addGestureRecognizer(tap)
       
       checkListSettingsViewModal.makeModalView()
       
        checkListSettingsRenameButton.makeSettingsButton(title: "Rename", icon: UIImage(named: "icon_edit")!, color: Theme.current.greenColor)
       
        checkListSettingsDeleteButton.makeSettingsButton(title: "Delete", icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        
        checkListSettingsColorSwitchButton.makeSettingsButton(title: "Color", icon: UIImage(named: "icon_color")!, color: Theme.current.appAccentColor)
    }

    @objc func outsideViewTouched(sender: UITapGestureRecognizer? = nil) {
       self.dismiss(animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
    }
    
    @IBAction func checkListSettingsRenameButtonPressed(_ sender: UIButton) {
        
        let nameEditStoryBoard = UIStoryboard(name: "TextEditView", bundle: nil)
        let textEditView = nameEditStoryBoard.instantiateInitialViewController() as! TextEditViewController
        
        textEditView.confirmFunction = {inputName in
            
            self.currentCheckList?.title = inputName
            
            CheckListFunctions.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)
            
            DispatchQueue.main.async {
                
                self.dismiss(animated: true)
                
                
                if let checkListView = self.presentingViewController as? CheckListViewController {
                    checkListView.currentCheckList = Data.checkListModels[checkListView.checkListIndex!]
                    checkListView.viewDidLoad()
                }
                
            }
        }
        
        textEditView.cancelFunction = {
            self.dismiss(animated: true)
        }
        
        self.present(textEditView, animated: true)
        textEditView.prepareTextEditInput(color: ThemeFunctions.getColorFromName(colorName: self.currentCheckList!.color), currentName: self.currentCheckList!.title)
        
    }
    
    @IBAction func checkListSettingsDeleteButtonPressed(_ sender: UIButton) {
        
        let confirmationStoryBoard = UIStoryboard(name: "ConfirmationView", bundle: nil)
        
        let confirmationView = confirmationStoryBoard.instantiateInitialViewController() as! ConfirmationViewController
        
        let checkListIdToDelete = self.currentCheckList!.id
        
        confirmationView.yesFunction = {
            
            CheckListFunctions.deleteCheckListById(checkListId: checkListIdToDelete) { (deletedCheckListIndex) in
                
                DispatchQueue.main.async {
                    
                    self.dismiss(animated: true)
                    
                    
                    if let checkListView = self.presentingViewController as? CheckListViewController {
                        checkListView.closeCheckListView()

                    }
                    
                }
                
            }
            
        }
        
        confirmationView.noFunction = {
            self.dismiss(animated: true)
        }
        
        self.present(confirmationView, animated: true, completion: nil)
        
    }
    
    @IBAction func checkListSettingsColorSwitchButtonPressed(_ sender: UIButton) {
        
        self.currentCheckList!.color = ThemeFunctions.switchListColor(currentColorName: self.currentCheckList!.color)
        
        CheckListFunctions.updateCheckListById(checkListId: self.currentCheckList!.id, updatedCheckList: self.currentCheckList!)
        
        DispatchQueue.main.async {
            
            if let checkListView = self.presentingViewController as? CheckListViewController {
                checkListView.currentCheckList = Data.checkListModels[checkListView.checkListIndex!]
                checkListView.viewDidLoad()
            }
            
        }
        
    }
    
    
}
