//
//  ProfileViewController.swift
//  Project
//
//  Created by Thomas BERRANGER on 13/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    let username:String = "Thomas"
    let password:String = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = username
        passwordLabel.text = password
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
