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
        dateTimeSelectionView.setupColors(listColor: Theme.getColorFromName(colorName: self.currentCheckList!.color))
        
    }
    
    func setupCalendarForList(callback: @escaping (EKEventStore, EKCalendar) -> Void) {
        
        var listCalendar: EKCalendar?
        let listCalendarTitle = self.currentCheckList!.title + " Reminders"
        
        let eventStore = EKEventStore()
             
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
           granted, error in
            if (!granted) || (error != nil) {
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: "Can't access reminders", message: "Please allow access to Reminders in Settings", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
            }else{
                let calendars = eventStore.calendars(for: .reminder)
                if calendars.first(where: {$0.title == listCalendarTitle}) != nil {
                    print("Found Existing Calendar for List")
                    listCalendar = calendars.first(where: {$0.title == listCalendarTitle})
                    callback(eventStore, listCalendar!)
                } else {
                    listCalendar = EKCalendar(for: .reminder, eventStore: eventStore)
                    listCalendar!.title = listCalendarTitle
                    listCalendar!.cgColor = Theme.current.appAccentColor.cgColor
                    listCalendar!.source = eventStore.defaultCalendarForNewReminders()?.source
                    do {
                        print("Creating Calendar for List")
                        print(listCalendar)
                        try eventStore.saveCalendar(listCalendar!, commit: true)
                        callback(eventStore, listCalendar!)
                    }catch {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "Couldn't create a list to add reminders", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
            
        })
    }
    
    func reminderChosen(initialDate: Date, repeatMonths: Int, repeatDays: Int, repeatCount: Int){
        
        setupCalendarForList { (eventStore, listCalendar) in
            
            print(initialDate, repeatMonths, repeatDays, repeatCount)
            
            
            if(repeatCount > 0){
                
                var datesToAdd = repeatCount + 1
                var tempDate = initialDate
                
                while(datesToAdd > 0){
                    
                    let reminderAdded = self.AddReminder(reminderText: "Review " + self.currentCheckList!.title, reminderDate: tempDate, listCalendar: listCalendar, eventStore: eventStore)
                    
                    if(reminderAdded == false){
                        return
                    }
                    
                    var newDateComponents = DateComponents()
                    newDateComponents.month = repeatMonths
                    newDateComponents.day = repeatDays
                    
                    tempDate = Calendar.current.date(byAdding: newDateComponents, to: tempDate)!
                    print(tempDate)
                    
                    datesToAdd = datesToAdd - 1
                }
                
            }else{
                let reminderAdded = self.AddReminder(reminderText: "Review " + self.currentCheckList!.title, reminderDate: initialDate, listCalendar: listCalendar, eventStore: eventStore)
                if(reminderAdded == false){
                   return
                }
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Reminders Added", message: "Added " + String(repeatCount + 1) + " reminders successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true)
            }
            
            
        }
        
    }
    
    func AddReminder(reminderText: String, reminderDate: Date, listCalendar: EKCalendar, eventStore: EKEventStore) -> Bool {

        var reminderAdded = false

        let reminder:EKReminder = EKReminder(eventStore: eventStore)
        reminder.title = reminderText

        let alarm = EKAlarm(absoluteDate: reminderDate)
        reminder.addAlarm(alarm)

        reminder.calendar = listCalendar

        do {
            try eventStore.save(reminder, commit: true)
            reminderAdded = true
        } catch {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Couldn't add this reminder.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        return reminderAdded
    }
}
