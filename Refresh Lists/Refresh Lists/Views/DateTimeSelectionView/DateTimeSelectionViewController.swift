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
        
    }
    
    func setupColors(backgroundColor: UIColor){
        //self.dateTimeSelectionModalView.backgroundColor = backgroundColor
    }
    
    func setupText(titleText: String){
        self.dateTimeSelectionTitleLabel.makeCheckListCardTitle(title: titleText, maxLength: 50)
    }
    
    
    @IBAction func dateTimeSelectionCancelButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
}
