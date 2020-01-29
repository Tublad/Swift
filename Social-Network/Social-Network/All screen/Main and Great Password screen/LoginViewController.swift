
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    var rightLogin = "Евген"
    var rightPassword = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      // пример работы Singleton
        func sendRequest() {
            print(Session.shared.userId)
            print(Session.shared.token)
        }
        
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(hideAction)
        reloadInputViews()
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
        
        
        if loginInput == rightLogin && passwordInput == rightPassword  {
          //  performSegue(withIdentifier: "firstCase", sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Не верно внесены данные, возможно пароль или почта не корректны", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func greatAccountButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let greatPasswordViewController = storyboard.instantiateViewController(identifier: "GreatPasswordViewController") as? GreatPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(greatPasswordViewController, animated: true)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        greatPasswordViewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.view.reloadInputViews()
    }
    
}

