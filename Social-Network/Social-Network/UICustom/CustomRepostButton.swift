
import UIKit

class RepostButton: UIButton {
    
    var reposts: Bool = false {
        didSet {
            setupDefault()
        }
    }
    
    var repostCount: Int = 0 {
        didSet {
            setupDefault()
        }
    }
    
    func repost() {
        reposts = !reposts
        if reposts {
            setReposted()
        } else {
            disableReposted()
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
        setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        setTitle(String(describing: repostCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
    }
    
    private func setReposted() {
        repostCount += 1
        setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        setTitle(String(describing: repostCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
        animationRepost()
    }
    
    private func disableReposted() {
        repostCount -= 1
        setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        setTitle(String(describing: repostCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
        animationRepost()
    }
    
    private func animationRepost() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.2
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 1
        animation.duration = 2
        layer.add(animation, forKey: nil)
    }
    
}
