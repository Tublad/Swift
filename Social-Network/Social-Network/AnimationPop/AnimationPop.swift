

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.25
    var originalFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let conteinerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let recipeView = toView
        
        let finalFrame = recipeView.frame
        
        let xScaleFactor = originalFrame.width / finalFrame.width
        let yScaleFactor = originalFrame.height / finalFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        recipeView.transform = scaleTransform
        recipeView.center = CGPoint(x: originalFrame.midX, y: originalFrame.midY)
        
        recipeView.clipsToBounds = true
        
        conteinerView.addSubview(toView)
        conteinerView.bringSubviewToFront(toView)
        
        UIView.animate(withDuration: duration, animations: {
            recipeView.transform = .identity
            recipeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { isComplited in
            transitionContext.completeTransition(isComplited)
        }
    }
    
}

