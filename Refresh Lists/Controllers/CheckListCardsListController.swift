//
//  CheckListCardsList.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate{
    
    /// Sets the number of check lists to display
    /// - Parameters:
    ///   - tableView: Table View
    ///   - section: Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Display all check lists from local storage */
        return LocalStorage.checkListModels.count
    }
    
    /// Sets the view to display on each row to represent the Check List
    /// - Parameters:
    ///   - tableView: Table View
    ///   - indexPath: Index of Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkListCell") as! CheckListCardController
        
        /* Set View to a card representing checklist
            from same index in local storage
         */
        cell.setup(checkListModel: LocalStorage.checkListModels[indexPath.row])
        
        return cell
    }
    
    /// Set the height for each row
    /// - Parameters:
    ///   - tableView: Table View
    ///   - indexPath: Index of Row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    /// Handler for selecting a Check List
    /// - Parameters:
    ///   - tableView: Table View
    ///   - indexPath: Index of Selected Check List
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /* Prepare the Check List View*/
        let storyboard = UIStoryboard(name: "CheckListView", bundle: nil)
        let checkListView = storyboard.instantiateInitialViewController() as! CheckListViewController
        
        /* Adapt the toolbar */
        self.screenTitleLabel.text = "View List"
        self.appOptionsButton.isHidden = true
        self.newListButton.isHidden = true
        
        /* Set the Check List for the Check List View*/
        checkListView.currentCheckListIndex = indexPath.row
        
        /* Preset the Check List View */
        self.present(checkListView, animated: true, completion: nil)
    }
    
    /// Returns the Check List Card that was dragged
    /// - Parameters:
    ///   - tableView: Table View
    ///   - session: Session
    ///   - indexPath: Index of dragged card
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("started dragging")
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = LocalStorage.checkListModels[indexPath.row]
        return [ dragItem ]
    }
    
    /// Moves a Check List card from one position to another
    /// - Parameters:
    ///   - tableView: Table View
    ///   - sourceIndexPath: Origin Index
    ///   - destinationIndexPath: Destination Index
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        /* Move the Check List's Position in Local Storage*/
        LocalStorage.moveCheckList(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath) {
            DispatchQueue.main.async {
                
                /* Reload the view to display the new order*/
                LocalStorage.readCheckLists { [unowned self] in
                    self.checkListsTableView.reloadData()
                }
            }
        
        }
        
    }
    
}
