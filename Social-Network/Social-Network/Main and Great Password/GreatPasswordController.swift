//

import UIKit

class GreatPasswordController: UIViewController {
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    var logins: String?
    var passwords: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func pressentGreatButton(_ sender: Any) {
        guard let newLogin = newName.text,
            let newPas = newPassword.text,
            let repeatPas = repeatPassword.text else {
                return
        }
        guard newLogin.count > 0 && newPas.count > 0 && repeatPas.count > 0, newLogin.count < 15 && newPas.count < 20 && repeatPas.count < 20 else {
            return
        }
        guard newPas == repeatPas else {
            return
        }
        if logins != newLogin && passwords != newPas {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
            vc.rightLogin = newLogin
            vc.rightPassword = newPas
           self.navigationController?.pushViewController(vc, animated: true)
            view.reloadInputViews()
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Проверьте введеный пароль, он должен совпадеть с первой записью пароля", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

}
