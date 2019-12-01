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
    
    
     var rightLogin = "Evgen"
     var rightPassword = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(hideAction)
    }
    
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @IBAction func pressent(_ sender: Any) {
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
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Не верно внесены данные, возможно пароль или почта не корректны", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        print("Hello \(loginInput) and your password \(passwordInput)")
    }
    
    @IBAction func forgetPasswordButton(_ sender: Any) {
        let lostName = rightLogin
        let lostPassword = rightPassword
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "GreatPasswordController") as! GreatPasswordController
        vc.logins = lostName
        vc.passwords = lostPassword
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

