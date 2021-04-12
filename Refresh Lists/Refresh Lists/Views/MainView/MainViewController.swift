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
    @IBOutlet var newListBotton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        screenTitleLabel.makeScreenTitleLabel()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
