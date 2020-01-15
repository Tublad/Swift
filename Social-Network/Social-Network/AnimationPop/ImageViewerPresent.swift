

import UIKit

protocol ImageViewerPresenterSource: UIViewController {
    var source: UIView? { get }
}

class ImageViewerPresenter: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    var animatorSource: ImageViewerPresenterSource?
    var animator = PopAnimator()
    
    
    init(delegate: ImageViewerPresenterSource) {
        animatorSource = delegate
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let sourceView = animatorSource?.source,
            let origin = sourceView.superview?.convert(sourceView.frame,
                                                       to: UIApplication.topViewController()!.navigationController!.view) else {
            return nil
        }
        
        animator.originalFrame = CGRect(x: origin.minX,
                                        y: origin.minY,
                                        width: origin.size.width,
                                        height: origin.size.height)
        return animator
    }
    
}
