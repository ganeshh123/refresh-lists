//
//  TextEditViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 27/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View Controller for Text Edit View
class TextEditViewController: UIViewController {
    
    /// View outside the modal
    @IBOutlet var outsideView: UIView!
    /// Modal for Text Edit View
    @IBOutlet var modalView: UIView!
    /// Text Field for enterning new/updated name
    @IBOutlet var inputBox: UITextField!
    /// Button to cancel Text Edit Dialog
    @IBOutlet var cancelButton: UIButton!
    /// Button to confirm Text Edit Dialog
    @IBOutlet var confirmButton: UIButton!
    
    /// Member function to run with input value after confirmation
    var confirmFunction: (String) -> () = {_ in }
    /// Member function to run after dialog cancelled
    var cancelFunction: () -> () = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Style view and buttons */
        modalView.makeModalView()
        confirmButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        cancelButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        
        
    }
    
    
    /// Prepares the text field of the name input
    /// - Parameters:
    ///   - color: Background color of text field
    ///   - currentName: Existing value for the text field
    ///   - placeholder: Placeholder for the text field
    func prepareTextEditInput(color: UIColor, currentName: String, placeholder: String = ""){
        
        /* Style Text Field */
        inputBox.makeNameEditInput(backgroundColor: color, text: currentName, placeholder: placeholder)
        
        /* Place focus on text field */
        inputBox.becomeFirstResponder()
    }
    
    /// Handler function to run when the user types in the Text Field
    /// - Parameter sender: Text Field that was edited
    @IBAction func textEditInputBoxTextChanged(_ sender: UITextField) {
        
        /* Remove Stylings for Invalid Inputs */
        inputBox.clearInvalidInput()
        
    }
    
    /// Handler function to run when confirum button pressed
    /// - Parameter sender: Button that was pressed
    @IBAction func textEditConfirmButtonPressed(_ sender: UIButton) {
        
        if(inputBox.text == ""){
            /* Apply styling to show invalid input */
            inputBox.invalidInput()
        }else{
            
            /* Run the confirm function providing the text input*/
            self.confirmFunction(inputBox.text!)
            /* Close the view */
            self.dismiss(animated: true)
        }
        
    }
    
    
    /// Handler function to run when cancel button pressed
    /// - Parameter sender: Button that was pressed
    @IBAction func textEditCancelButtonPressed(_ sender: UIButton) {
        
        /* Dismiss the view */
        self.dismiss(animated: true)
        
        /* Run the cancel function */
        self.cancelFunction()
    }
    
}
