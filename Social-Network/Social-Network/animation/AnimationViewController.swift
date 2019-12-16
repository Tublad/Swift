
import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var animationLoadingView: UIView!
    @IBOutlet weak var animationSecondLoad: UIView!
    @IBOutlet weak var animationThreeLoad: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       animationPressent()
    }
    
    func animationPressent() {
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            self.animationThreeLoad.alpha = 0.5
            self.animationThreeLoad.alpha = 0
            self.animationSecondLoad.alpha = 0
            self.animationLoadingView.alpha = 0
            self.animationLoadingView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
                self.animationLoadingView.alpha = 0.5
                self.animationLoadingView.alpha = 0
                self.animationThreeLoad.alpha = 0
                self.animationSecondLoad.alpha = 0
                self.animationSecondLoad.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
                    self.animationSecondLoad.alpha = 0.5
                    self.animationSecondLoad.alpha = 0
                    self.animationLoadingView.alpha = 0
                    self.animationThreeLoad.alpha = 0
                    self.animationThreeLoad.alpha = 1
                }, completion: { _ in self.animationPressent()})
            })
        })
    }
}
