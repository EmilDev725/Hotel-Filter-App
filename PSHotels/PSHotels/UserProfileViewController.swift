//
//  UserProfileViewController.swift
//
//  Created by Panacea-soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class UserProfileViewController: PSUIViewController {
    
    
    // MARK: IBOutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profileView: ProfileView!
   
    @IBOutlet weak var editMenuButton: UIBarButtonItem!
    
    // MARK: Override Functions
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.selectedMenuIndex = 7
            
        super.controllerTitle = language.profileTitle
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        profileView.setup()
        
        editMenuButton.tintColor = configs.colorTextAlt
        
    }
    
    @IBAction func editProfileClicked(_ sender: Any) {
        profileView.openUserProfileEdit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare Segue")
    }
    
  
}
