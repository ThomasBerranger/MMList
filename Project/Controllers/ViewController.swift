//
//  ViewController.swift
//  Project
//
//  Created by Thomas BERRANGER on 06/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let username:String = "Thomas"
    let password:String = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
        
        guard let testUsername = usernameField.text, !testUsername.isEmpty else {
            signInLabel.text = "Sign in : No username !"
            signInLabel.textColor = UIColor.red;
            return
        }
        
        guard let testPassword = passwordField.text, !testPassword.isEmpty else {
            signInLabel.text = "Sign in : No pasword !"
            signInLabel.textColor = UIColor.red;
            return
        }
        
        guard usernameField.text == username else {
            signInLabel.text = "Sign in : Bad username !"
            signInLabel.textColor = UIColor.red;
            return
        }
        
        guard passwordField.text == password else {
            signInLabel.text = "Sign in : Bad password !"
            signInLabel.textColor = UIColor.red;
            return
        }

        usernameField.text = nil
        passwordField.text = nil
        self .performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    

}

