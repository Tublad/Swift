
import UIKit

class GreatPasswordViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var nameViewLabel: UILabel!
    @IBOutlet weak var greatAccButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    let standartAnimator = AnimatedTransition()
    var transitionInteraction: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyBoard()
        installViewAlpha()
        animationImageAlpha()
        
        let edgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgeRecognizer(_:)))
        view.addGestureRecognizer(edgeRecognizer)
        edgeRecognizer.edges = .left
        
        navigationController?.delegate = self
    }
    
    // а тут и вовсе не получилось использовать интерактивную анимацию, пытался пытался и почему то не вышло, наверно плохо понял, либо уже запутался (
    
    @objc func edgeRecognizer(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let transition = gesture.translation(in: gesture.view)
        let percentComplete = transition.x / gesture.view!.bounds.size.width
        
        switch gesture.state {
        case .began:
            transitionInteraction = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
        case .changed:
            transitionInteraction?.update(percentComplete)
        case .ended:
            let vecolity = gesture.velocity(in: gesture.view)
            if vecolity.x > 0 || percentComplete > 0.5 {
                transitionInteraction?.finish()
            } else {
                transitionInteraction?.cancel()
            }
            transitionInteraction = nil
        default: break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionInteraction
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
            
            mainViewController.modalPresentationStyle = .custom
            mainViewController.modalPresentationCapturesStatusBarAppearance = true
            mainViewController.transitioningDelegate = self.standartAnimator
            present(mainViewController, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Пароль не идентичен, проверьте написание", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func comeBackButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainView = storyboard.instantiateViewController(identifier: "ViewController")
        mainView.modalPresentationStyle = .custom
        mainView.modalPresentationCapturesStatusBarAppearance = true
        mainView.transitioningDelegate = self.standartAnimator
        present(mainView, animated: true, completion: nil)
    }
}
