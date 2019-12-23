
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var greatButton: UIButton!
    
    
    var rightLogin = "Евген"
    var rightPassword = "12345"
    
   let standartAnimator = AnimatedTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyBoard()
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabView = storyboard.instantiateViewController(identifier: "tabBar")
            tabView.modalPresentationStyle = .custom
            tabView.modalPresentationCapturesStatusBarAppearance = true
            tabView.transitioningDelegate = self.standartAnimator
            present(tabView, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Не верно внесены данные, возможно пароль или почта не корректны", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func greatAccountButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabView = storyboard.instantiateViewController(identifier: "greatPasswordNav")
        tabView.modalPresentationStyle = .custom
        tabView.modalPresentationCapturesStatusBarAppearance = true
        tabView.transitioningDelegate = self.standartAnimator
        present(tabView, animated: true, completion: nil)
    }
    
}

/*
 здесь получилось реализовать корректно, но единственное получается только в одну сторону крутить, и понимаю, потому что вызывается функция Push, а не Pop!
 Но если начинаю изменять и делать через NavigationController, то вообще анимация не происходит, возножно упускаю какую то мелочь, но уже взгляд притупился )) помогите пожалуйста =)ы
 */

class AnimatedTransition: NSObject ,UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var preseting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let conteiner = transitionContext.containerView
        
       guard let source = transitionContext.viewController(forKey: .from),
        let to = transitionContext.viewController(forKey: .to) else { return }
        
        let π = CGFloat(M_PI)
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2 )
        
        to.view.transform = self.preseting ? offScreenRotateOut : offScreenRotateIn
        
        to.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        to.view.layer.position = CGPoint(x: 0, y: 0)
        source.view.layer.position = CGPoint(x: 0, y: 0)
        
        
        conteiner.addSubview(to.view)
        conteiner.addSubview(source.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.49 , initialSpringVelocity: 0.81, options: [], animations: {
            if self.preseting {
                source.view.transform = offScreenRotateIn
            } else {
                source.view.transform = offScreenRotateOut
            }
        
            to.view.transform = CGAffineTransform.identity
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.preseting = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.preseting = false
        return self
    }
}
 
