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
    
    var checkListId: UUID?

    override func viewDidLoad() {
       super.viewDidLoad()

       // Do any additional setup after loading the view.
       
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.outsideViewTouched(sender:)))
       checkListSettingsOutsideView.isUserInteractionEnabled = true
       checkListSettingsOutsideView.addGestureRecognizer(tap)
       
       checkListSettingsViewModal.makeModalView()
       
        checkListSettingsRenameButton.makeSettingsButton(title: "Rename", icon: UIImage(named: "icon_edit")!, color: Theme.current.greenColor)
       
        checkListSettingsDeleteButton.makeSettingsButton(title: "Delete", icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
    }

    @objc func outsideViewTouched(sender: UITapGestureRecognizer? = nil) {
       self.dismiss(animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
    }
    
    @IBAction func checkListSettingsRenameButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func checkListSettingsDeleteButtonPressed(_ sender: UIButton) {
        
        let confirmationStoryBoard = UIStoryboard(name: "ConfirmationView", bundle: nil)
        
        let confirmationView = confirmationStoryBoard.instantiateInitialViewController() as! ConfirmationViewController
        
        confirmationView.yesFunction = {
            
            CheckListFunctions.deleteCheckListById(checkListId: self.checkListId!) { (deletedCheckListIndex) in
                
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
    
}
