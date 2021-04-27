//
//  MainViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 12/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var screenTitleLabel: UILabel!
    @IBOutlet var appOptionsButton: UIButton!
    @IBOutlet var newListButton: UIButton!
    @IBOutlet var checkListsTableView: UITableView!
    
    static var screenTitle = "Your Lists"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
        mainView.backgroundColor = Theme.current.appBackgroundColor
        
        /* Setup Buttons */
        appOptionsButton.makeMainAppButton()
        newListButton.makeMainAppButton()
        
        screenTitleLabel.makeScreenTitleLabel(text: "Your Lists")
        
        checkListsTableView.dataSource = self
        checkListsTableView.delegate = self
        CheckListFunctions.readCheckLists { [unowned self] in
            self.checkListsTableView.reloadData()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func setScreenTitleLabel(text: String){
        //self.screenTitleLabel = text
    }
    
    @IBAction func appOptionsPressed(_ sender: UIButton) {
        
       
    }
    

}
