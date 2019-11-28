//
//  ViewController.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 23/11/2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let rightLogin = "Evgen"
    private let rightPassword = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(hideAction)
    }
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @IBAction func pressButton(_ sender: Any) {
        guard let loginInput = login.text,
            let passwordInput = password.text else {
                return
        }
        guard loginInput.count > 0 && loginInput.count < 15 else {
            return
        }
        guard passwordInput.count > 0 && passwordInput.count < 20 else {
            return
        }
        
        if loginInput == rightLogin && passwordInput == rightPassword {
            performSegue(withIdentifier: "firstCase", sender: nil)
        }
        
        print("Hello \(loginInput) and your password \(passwordInput)")
    }
    
}

