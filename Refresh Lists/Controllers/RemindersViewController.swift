//
//  RemindersViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 30/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View Controller for Reminders View
class RemindersViewController: UIViewController {
    
    /// View outside the modal
    @IBOutlet var outsideView: UIView!
    /// Modal for Reminder View
    @IBOutlet var modalView: UIView!
    /// Title Label
    @IBOutlet var titleLabel: UILabel!
    
    /// Label instruction for choosing an initial reminder time
    @IBOutlet var initialReminderLabel: UILabel!
    /// Date/Time Picker for choosing an initial reminder time
    @IBOutlet var initialDatePicker: UIDatePicker!
    
    /// Label instruction for choosing a recurring reminder
    @IBOutlet var continuedReminderLabel: UILabel!
    /// Text field for inputting a month for recurring reminder
    @IBOutlet var monthTextField: UITextField!
    @IBOutlet var dateTimeSelectionMonthLabel: UILabel!
    /// Text field for inputting a day for recurring reminder
    @IBOutlet var dateTimeSelectionDayTextField: UITextField!
    @IBOutlet var dateTimeSelectionDayLabel: UILabel!
    @IBOutlet var dateTimeSelectionForLabel: UILabel!
    /// Text field for inputting a quantitiy of recurring reminders to set
    @IBOutlet var dateTimeSelectionRepeatTextField: UITextField!
    @IBOutlet var dateTimeSelectionTimesLabel: UILabel!
    
    /// Button to cancel add reminder dialog
    @IBOutlet var dateTimeSelectionCancelButton: UIButton!
    /// Button to confirm add reminder dialog
    @IBOutlet var dateTimeSelectionConfirmButton: UIButton!
    
    /// Member function which needs to be assigned -> adds reminder from inputs in the dialog box
    var addReminderFunc: (_ initialDate: Date, _ repeatMonths: Int, _ repeatDays: Int, _ repeatCount: Int) -> () = {_,_,_,_ in }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up view and buttons
        self.modalView.makeModalView()
        self.modalView.backgroundColor = Theme.current.appBackgroundColor
        self.dateTimeSelectionCancelButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        self.dateTimeSelectionConfirmButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        
        // Set Text
        self.titleLabel.makeCheckListCardTitle(title: "Add List Reminder", maxLength: 50)
        initialReminderLabel.makeDateTimeSelectionInfoText(text: "Send me an initial reminder on")
        continuedReminderLabel.makeDateTimeSelectionInfoText(text: "Then, continue to remind me every")
        dateTimeSelectionMonthLabel.makeDateTimeSelectionInfoText(text: "months, and ")
        dateTimeSelectionDayLabel.makeDateTimeSelectionInfoText(text: "days")
        dateTimeSelectionForLabel.makeDateTimeSelectionInfoText(text: "for exactly")
        dateTimeSelectionTimesLabel.makeDateTimeSelectionInfoText(text: "times.")
        
        // Set up Initial Date Picker
        initialDatePicker.minimumDate = Date()
        initialDatePicker.setValue(Theme.current.appAccentColor, forKeyPath: "textColor")
        initialDatePicker.setValue(false, forKeyPath: "highlightsToday")
        
        
    }
    
    /// Applies the color theme from the check list to the reminders dialog
    /// - Parameter listColor: Color of the checklist
    func applyCheckListColor(listColor: UIColor){
        
        // Apply check list's color to all the text fields and the date picker
        self.monthTextField.makeDateTimeSelectionTextField(backgroundColor: listColor)
        self.dateTimeSelectionDayTextField.makeDateTimeSelectionTextField(backgroundColor: listColor)
        self.dateTimeSelectionRepeatTextField.makeDateTimeSelectionTextField(backgroundColor: listColor)
        self.initialDatePicker.backgroundColor = listColor
    }
    
    /// Handler function for the cancel button pressed
    /// - Parameter sender: Button that was pressed
    @IBAction func dateTimeSelectionCancelButtonPressed(_ sender: UIButton) {
        
        // Dismiss the view
        self.dismiss(animated: true)
        
    }
    
    /// Returns a boolean indicating if all text fields in the reminder dialog contain valid inputs
    func validateInputs() -> Bool{
        
        // Remove invalid input styling from all text fields
        monthTextField.clearInvalidInput()
        dateTimeSelectionDayTextField.clearInvalidInput()
        dateTimeSelectionRepeatTextField.clearInvalidInput()
        
        // If any of the fields contain and empty input or contain
        // non-integer values, style them as invalid and return false
        var allInputsValid = true
        
        let monthTextFieldValue = monthTextField.text
        if(monthTextFieldValue == "" || Int(monthTextFieldValue!) == nil){
            monthTextField.invalidInput()
            allInputsValid = false
        }
        
        let dayTextFieldValue = dateTimeSelectionDayTextField.text
        if(dayTextFieldValue == "" ||  Int(dayTextFieldValue!) == nil){
            dateTimeSelectionDayTextField.invalidInput()
            allInputsValid = false
        }
        
        let repeatTextFieldValue = dateTimeSelectionRepeatTextField.text
        if(repeatTextFieldValue == "" ||  Int(repeatTextFieldValue!) == nil){
           dateTimeSelectionRepeatTextField.invalidInput()
            allInputsValid = false
        }
        
        return allInputsValid
    }
    
    /// Handler function for the confirum button pressed
    /// - Parameter sender: Button that was pressed
    @IBAction func dateTimeSelectionConfirmButtonPressed(_ sender: UIButton) {
        
        // Don't proceed if some inputs are invalid
        if(self.validateInputs() == false){
            return
        }
        
        // Get values from date picker and text fields
        let initialDate = self.initialDatePicker.date
        let repeatMonths = Int(self.monthTextField.text!)
        let repeatDays = Int(self.dateTimeSelectionDayTextField.text!)
        let repeatCount = Int(self.dateTimeSelectionRepeatTextField.text!)
        
        // Dismiss the dialog
        self.dismiss(animated: true)
        
        // Call the function to add reminders with the inputs
        addReminderFunc(initialDate, repeatMonths!, repeatDays!, repeatCount!)
    }
}
