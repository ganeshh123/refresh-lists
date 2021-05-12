//
//  RemindersController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 30/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import Foundation
import UIKit
import EventKit

extension CheckListViewController{
    
    /// Creates or Finds an EKCalendar Instance representing the Calender Collection of Reminders for the Check List
    /// - Parameter callback: Function to run with the Found/Created Reminders Collection and Event Store
    func getRemindersCollection(callback: @escaping (EKEventStore, EKCalendar) -> Void) {
        
        /* Initialize an EventStore instance to access Reminders */
        let eventStore = EKEventStore()
        
        /// EKCalendar Instance representing the Calender Collection of Reminders for the Check List
        var remindersCollection: EKCalendar?
        /// Title of Reminders Collection to create or find
        let remindersCollectionTitle = self.currentCheckList!.title + " Reminders"
             
        /* Request Permission to Access Reminders */
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
           granted, error in
            if (!granted) || (error != nil) {
                
                /* Permission Denied */
                
                DispatchQueue.main.async{
                    
                    /* Alert the user to allow Reminders Permission from iOS Settings */
                    let alert = UIAlertController(title: "Can't access reminders", message: "Please allow access to Reminders in Settings", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                
            }else{
                
                /* Permision Granted */
                
                /// Collections in the user's Reminders App
                let remindersCollections = eventStore.calendars(for: .reminder)
                
                if remindersCollections.first(where: {$0.title == remindersCollectionTitle}) != nil {
                    
                    /* If there's already a collection for the Check List, then run the callback */
                    remindersCollection = remindersCollections.first(where: {$0.title == remindersCollectionTitle})
                    callback(eventStore, remindersCollection!)
                    
                } else {
                    
                    /* Create a Collection in Reminders for the Check List and set the title */
                    remindersCollection = EKCalendar(for: .reminder, eventStore: eventStore)
                    remindersCollection!.title = remindersCollectionTitle
                    
                    /* Set the source of the calendar collection to be reminders */
                    remindersCollection!.source = eventStore.defaultCalendarForNewReminders()?.source
                    
                    do {
                        /* Write the new collection to the Reminders App, then run the callback */
                        try eventStore.saveCalendar(remindersCollection!, commit: true)
                        callback(eventStore, remindersCollection!)
                    }catch {
                        
                        /* Error occured creating the collection in Reminders */
                        
                        DispatchQueue.main.async {
                            
                            /* Alert the user that an error occured */
                            let alert = UIAlertController(title: "Error", message: "Couldn't create a collection in the Reminders App", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
            
        })
    }
    
    /// Creates a Reminder in the Reminders App, and returns a boolean indicating if it was added successfully
    /// - Parameters:
    ///   - reminderText: Text of the Reminder
    ///   - reminderDate: Date for the Reminder's Alarm
    ///   - listCalendar: Calendar Collection to Add Reminder
    ///   - eventStore: Event Store instance to access reminders
    func createReminder(reminderText: String, reminderDate: Date, remindersCollection: EKCalendar, eventStore: EKEventStore) -> Bool {

        
        /// Specifies if Reminder was added successfully
        var reminderAdded = false
        
        
        /// EKReminder Instance representing the reminder to be added
        let reminder:EKReminder = EKReminder(eventStore: eventStore)
        
        /* Set the text and the alarm for the reminder */
        reminder.title = reminderText
        let alarm = EKAlarm(absoluteDate: reminderDate)
        reminder.addAlarm(alarm)

        /* Assigns the Collection to place the new reminder */
        reminder.calendar = remindersCollection

        do {
            /* Try and save the Reminder */
            try eventStore.save(reminder, commit: true)
            reminderAdded = true
        } catch {
            /* Error Occured */
            
            /* Alert the user that there was an error creating the reminder */
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Couldn't add this reminder.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        /* Return the status of the Reminder Creation Operation */
        return reminderAdded
    }
    
    /// Creates multiple reminders in Reminders App
    /// - Parameters:
    ///   - initialDate: Date and Time for the Initial Reminder
    ///   - repeatMonths: Month Frequency for Additional Reminders (0 for none)
    ///   - repeatDays: Day Frequency for Additional Reminders (0 for none)
    ///   - repeatCount: Number of additional reminders to create
    func addReminders(initialDate: Date, repeatMonths: Int, repeatDays: Int, repeatCount: Int){
        
        /* Get a collection in the Reminders App to write Reminders into */
        getRemindersCollection { (eventStore, collection) in
            
            /* Create the reminder for the initial date/time  */
            let reminderAdded = self.createReminder(reminderText: "Review " + self.currentCheckList!.title, reminderDate: initialDate, remindersCollection: collection, eventStore: eventStore)
            if(reminderAdded == false){
                /* Stop if an error occured */
                return
            }
            
            if(repeatCount > 0){
                
                /* User Requested to create Multiple Reminders */
                
                /// Number of Reminders left to add
                var remindersToAdd = repeatCount
                /// Date of the Reminder to be created
                var newReminderDate = initialDate
                
                while(remindersToAdd > 0){
                    
                    /* There are reminders still left to create */
                    
                    /* Add specified frequency months and days to create the new reminder's date */
                    var newDateComponents = DateComponents()
                    newDateComponents.month = repeatMonths
                    newDateComponents.day = repeatDays
                    newReminderDate = Calendar.current.date(byAdding: newDateComponents, to: newReminderDate)!
                    
                    /* Add the new reminder */
                    let reminderAdded = self.createReminder(reminderText: "Review " + self.currentCheckList!.title, reminderDate: newReminderDate, remindersCollection: collection, eventStore: eventStore)
                    if(reminderAdded == false){
                        /* Stop if error occured */
                        return
                    }
                    
                    /* Decrement the number of reminders left to create */
                    remindersToAdd = remindersToAdd - 1
                }
                
            }
            
            /* All Reminders added successfully */
            
            DispatchQueue.main.async {
                
                /* Inform the user of the Number of Reminders that were created */
                let alert = UIAlertController(title: "Reminders Added", message: "Added " + String(repeatCount + 1) + " reminders successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true)
            }
            
            
        }
        
    }
    
}
