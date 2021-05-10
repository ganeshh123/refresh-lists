//
//  DateTimeSelectionViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 30/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class DateTimeSelectionViewController: UIViewController {
    
    @IBOutlet var outsideView: UIView!
    @IBOutlet var dateTimeSelectionModalView: UIView!
    @IBOutlet var dateTimeSelectionTitleLabel: UILabel!
    
    @IBOutlet var dateTimeSelectionInitialReminderLabel: UILabel!
    @IBOutlet var dateTimeSelectionInitialDatePicker: UIDatePicker!
    
    @IBOutlet var dateTimeContinuedReminderLabel: UILabel!
    @IBOutlet var dateTimeSelectionMonthTextField: UITextField!
    @IBOutlet var dateTimeSelectionMonthLabel: UILabel!
    @IBOutlet var dateTimeSelectionDayTextField: UITextField!
    @IBOutlet var dateTimeSelectionDayLabel: UILabel!
    @IBOutlet var dateTimeSelectionForLabel: UILabel!
    @IBOutlet var dateTimeSelectionRepeatTextField: UITextField!
    @IBOutlet var dateTimeSelectionTimesLabel: UILabel!
    
    @IBOutlet var dateTimeSelectionCancelButton: UIButton!
    @IBOutlet var dateTimeSelectionConfirmButton: UIButton!
    
    var addReminderFunc: (_ initialDate: Date, _ repeatMonths: Int, _ repeatDays: Int, _ repeatCount: Int) -> () = {_,_,_,_ in }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateTimeSelectionModalView.makeModalView()
        self.dateTimeSelectionModalView.backgroundColor = Theme.current.appBackgroundColor
        self.dateTimeSelectionCancelButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        self.dateTimeSelectionConfirmButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        
        /* Set Text */
        dateTimeSelectionInitialReminderLabel.makeDateTimeSelectionInfoText(text: "Send me an initial reminder on")
        dateTimeContinuedReminderLabel.makeDateTimeSelectionInfoText(text: "Then, continue to remind me every")
        dateTimeSelectionMonthLabel.makeDateTimeSelectionInfoText(text: "months, and ")
        dateTimeSelectionDayLabel.makeDateTimeSelectionInfoText(text: "days")
        dateTimeSelectionForLabel.makeDateTimeSelectionInfoText(text: "for exactly")
        dateTimeSelectionTimesLabel.makeDateTimeSelectionInfoText(text: "times.")
        
        dateTimeSelectionInitialDatePicker.minimumDate = Date()
        dateTimeSelectionInitialDatePicker.setValue(Theme.current.appAccentColor, forKeyPath: "textColor")
        dateTimeSelectionInitialDatePicker.setValue(false, forKeyPath: "highlightsToday")
        
        
    }
    
    func setupColors(listColor: UIColor){
        
        self.dateTimeSelectionMonthTextField.makeDateTimeSelectionTextField(backgroundColor: listColor)
        self.dateTimeSelectionDayTextField.makeDateTimeSelectionTextField(backgroundColor: listColor)
        self.dateTimeSelectionRepeatTextField.makeDateTimeSelectionTextField(backgroundColor: listColor)
        
        self.dateTimeSelectionInitialDatePicker.backgroundColor = listColor
    }
    
    func setupText(titleText: String){
        self.dateTimeSelectionTitleLabel.makeCheckListCardTitle(title: titleText, maxLength: 50)
    }
    
    
    @IBAction func dateTimeSelectionCancelButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    func validateInputs() -> Bool{
        
        dateTimeSelectionMonthTextField.clearInvalidInput()
        dateTimeSelectionDayTextField.clearInvalidInput()
        dateTimeSelectionRepeatTextField.clearInvalidInput()
        var allInputsValid = true
        
        let monthTextFieldValue = dateTimeSelectionMonthTextField.text
        if(monthTextFieldValue == "" || Int(monthTextFieldValue!) == nil){
            dateTimeSelectionMonthTextField.invalidInput()
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
    
    @IBAction func dateTimeSelectionConfirmButtonPressed(_ sender: UIButton) {
        
        if(self.validateInputs() == false){
            return
        }
        
        let initialDate = self.dateTimeSelectionInitialDatePicker.date
        let repeatMonths = Int(self.dateTimeSelectionMonthTextField.text!)
        let repeatDays = Int(self.dateTimeSelectionDayTextField.text!)
        let repeatCount = Int(self.dateTimeSelectionRepeatTextField.text!)
        
        self.dismiss(animated: true)
        addReminderFunc(initialDate, repeatMonths!, repeatDays!, repeatCount!)
    }
}
