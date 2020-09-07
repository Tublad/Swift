

import UIKit

class CommintButton: UIButton {
    
    var commented: Bool = false {
        didSet {
            setupDefault()
        }
    }
    
    var commentCount: Int = 0 {
        didSet {
            setupDefault()
        }
    }
    
    func commet() {
        commented = !commented
        if commented {
            setCommented()
        } else {
            disableCommented()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefault()
    }
    
    private func setupDefault() {
        setImage(UIImage(systemName: "bubble.middle.bottom"), for: .normal)
        setTitle(String(describing: commentCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
    }
    
    private func setCommented() {
        commentCount += 1
        setImage(UIImage(systemName: "bubble.middle.bottom"), for: .normal)
        setTitle(String(describing: commentCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
        animationComment()
    }
    
    private func disableCommented() {
        commentCount -= 1
        setImage(UIImage(systemName: "bubble.middle.bottom"), for: .normal)
        setTitle(String(describing: commentCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
        animationComment()
    }
    
    private func animationComment() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.2
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 1
        animation.duration = 2
        layer.add(animation, forKey: nil)
    }
    
}
