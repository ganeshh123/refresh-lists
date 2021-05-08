//
//  CheckListReminder.swift
//  Refresh Lists
//
//  Created by Ganesh H on 30/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import UIKit
import EventKit

extension CheckListViewController{
    
    func showReminderPicker(){

        let storyboard = UIStoryboard(name: "DateTimeSelection", bundle: nil)
        
        let dateTimeSelectionView = storyboard.instantiateInitialViewController() as! DateTimeSelectionViewController
        
        dateTimeSelectionView.addReminderFunc = reminderChosen(initialDate:repeatMonths:repeatDays:repeatCount:)
        
        self.present(dateTimeSelectionView, animated: true)
        dateTimeSelectionView.setupText(titleText: "Add List Reminder")
        dateTimeSelectionView.setupColors(backgroundColor: ThemeFunctions.getColorFromName(colorName: self.currentCheckList!.color))
        
    }
    
    func reminderChosen(initialDate: Date, repeatMonths: Int, repeatDays: Int, repeatCount: Int){
        
    }
    
    func AddReminder(reminderText: String, reminderDate: Date ) {

    let eventStore = EKEventStore()
        
   eventStore.requestAccess(to: EKEntityType.reminder, completion: {
      granted, error in
      if (granted) && (error == nil) {
        print("granted \(granted)")


        let reminder:EKReminder = EKReminder(eventStore: eventStore)
        reminder.title = "Must do this!"
        reminder.priority = 1


        let alarmTime = Date().addingTimeInterval(1*60*24*3)
        let alarm = EKAlarm(absoluteDate: alarmTime)
        reminder.addAlarm(alarm)

        reminder.calendar = eventStore.defaultCalendarForNewReminders()


        do {
          try eventStore.save(reminder, commit: true)
        } catch {
          print("Cannot save")
          return
        }
        print("Reminder saved")
      }
     })

    }
    
}
