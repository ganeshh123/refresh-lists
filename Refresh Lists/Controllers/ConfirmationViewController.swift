//
//  ConfirmationViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 16/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View Controller for the Confirmation View
class ConfirmationViewController: UIViewController {
    
    /// View outside the modal
    @IBOutlet var outsideView: UIView!
    /// View for the confirmation dialog
    @IBOutlet var dialogView: UIView!
    /// Label for Confirmation Message
    @IBOutlet var messageLabel: UILabel!
    /// Cancel Button
    @IBOutlet var cancelButton: UIButton!
    /// Confirmation Button
    @IBOutlet var confirmButton: UIButton!
    
    
    /// Message for Confirmation Dialog
    var message: String = "Are you sure?"
    /// Function to run if Action Confirmed
    var confirmFunction: () -> () = {}
    /// Function to run if Action Cancelled
    var cancelFunction: () -> () = {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Style View */
        dialogView.makeModalView()
        confirmButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        cancelButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        
        /* Display Confirmation Message in Label */
        messageLabel.makeConfirmationMessageLabel(text: "Are you sure?", maxLength: 24)
        
    }
    
    /// Handler for Cancel Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func cancelButtonPressed(_ sender: Any) {
        /* Close the confirmation dialog, and run the cancel function*/
        self.dismiss(animated: true, completion: cancelFunction)
    }
    
    
    /// Handler for Confirm Button Pressed
    /// - Parameter sender: Button pressed
    @IBAction func confirmButtonPressed(_ sender: Any) {
        /* Close the confirmation dialog and run the confirm function */
        self.dismiss(animated: true, completion: confirmFunction)
    }
    
}
