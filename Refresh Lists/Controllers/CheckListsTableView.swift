//
//  CheckListsTableView.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorage.checkListModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkListCell") as! CheckListsTableViewCell
        
        cell.setup(checkListModel: LocalStorage.checkListModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "CheckListView", bundle: nil)
        
        let checkListView = storyboard.instantiateInitialViewController() as! CheckListViewController
        
        self.screenTitleLabel.text = "View List"
        self.appOptionsButton.isHidden = true
        self.newListButton.isHidden = true
        
        checkListView.checkListIndex = indexPath.row
        self.present(checkListView, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("started dragging")
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = LocalStorage.checkListModels[indexPath.row]
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        LocalStorage.moveCheckList(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath) {
            DispatchQueue.main.async {
                LocalStorage.readCheckLists { [unowned self] in
                    self.checkListsTableView.reloadData()
                }
            }
        
        }
        
    }
    
}
