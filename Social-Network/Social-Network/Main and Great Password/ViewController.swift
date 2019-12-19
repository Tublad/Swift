
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var greatButton: UIButton!
    
    var propertyAnimator: UIViewPropertyAnimator!
    
    var rightLogin = "Евген"
    var rightPassword = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyBoard()
        
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
            performSegue(withIdentifier: "firstCase", sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Не верно внесены данные, возможно пароль или почта не корректны", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func greatAccountButton(_ sender: Any) {
        performSegue(withIdentifier: "greatPasswordCase", sender: nil)
    }
    
}

