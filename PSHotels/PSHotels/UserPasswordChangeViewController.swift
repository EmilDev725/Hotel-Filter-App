//
//  UserPasswordChangeViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/8/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class UserPasswordChangeViewController: PSUIViewController {
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var passwordChangeView: PasswordChangeView!
    
    // MARK: Override Functions
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.passwordChangeTitle
        
        passwordChangeView.setup()
        
    }
}

