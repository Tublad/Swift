
import UIKit

class GreatPasswordViewController: UIViewController {
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(hideAction)
    }
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @IBAction func newGreatAccount(_ sender: Any) {
        guard let newLogin = newName.text,
            let newPassword = newPassword.text,
            let repeatPassword = repeatPassword.text else {
                return
        }
        guard newLogin.count > 0 && newLogin.count < 15 else {
            return
        }
        guard newPassword.count > 0 && newPassword.count < 20 else {
            return
        }
        if newPassword == repeatPassword {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let mainViewController = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController else {
                return
            }
            mainViewController.rightLogin = newLogin
            mainViewController.rightPassword = newPassword
            self.navigationController?.pushViewController(mainViewController, animated: true)
            mainViewController.reloadInputViews()
            
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Пароль не идентичен, проверьте написание", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
}


