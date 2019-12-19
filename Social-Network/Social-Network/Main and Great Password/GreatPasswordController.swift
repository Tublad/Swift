
import UIKit

class GreatPasswordViewController: UIViewController {
    
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var nameViewLabel: UILabel!
    @IBOutlet weak var greatAccButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    var propertyAnimator: UIViewPropertyAnimator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyBoard()
        installViewAlpha()
        animationImageAlpha()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognize(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    
    @objc func panRecognize(_ recognize: UIPanGestureRecognizer) {
        switch recognize.state {
        case .began:
            propertyAnimator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 1.0, animations: {
                self.logoImage.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            })
        case .changed:
            let translation = recognize.translation(in: self.view)
            propertyAnimator.fractionComplete = translation.y / 100
        case .ended:
            propertyAnimator.stopAnimation(true)
            propertyAnimator.addAnimations {
                self.logoImage.transform = .identity
            }
            propertyAnimator.startAnimation()
        default:
            break
        }
    }
    
    func addKeyBoard() {
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(hideAction)
    }
    
    func installViewAlpha() {
        logoImage.alpha = 0
        newName.alpha = 0
        newPassword.alpha = 0
        repeatPassword.alpha = 0
        nameViewLabel.alpha = 0
        greatAccButton.alpha = 0
    }
    
    func animationImageAlpha() {
        
        UIView.animate(withDuration: 1,
                       delay: 0.1,
                       animations: {
                        self.logoImage.alpha = 1
        })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       animations: {
                        self.nameViewLabel.alpha = 1
        })
        UIView.animate(withDuration: 1,
                       delay: 0.3,
                       animations: {
                        self.newName.alpha = 1
        })
        UIView.animate(withDuration: 1,
                       delay: 0.4,
                       animations: {
                        self.newPassword.alpha = 1
        })
        UIView.animate(withDuration: 1,
                       delay: 0.5,
                       animations: {
                        self.repeatPassword.alpha = 1
        })
        UIView.animate(withDuration: 1,
                       delay: 0.6,
                       animations: {
                        self.greatAccButton.alpha = 1
        })
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
            self.navigationController?.pushViewController(mainViewController, animated: false)
            let backButton = UIBarButtonItem()
            backButton.title = " "
            backButton.tintColor = .clear
        mainViewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            mainViewController.reloadInputViews()
            
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Пароль не идентичен, проверьте написание", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func comeBackButton(_ sender: Any) {
       performSegue(withIdentifier: "comeBackCase", sender: nil)
    }
}

