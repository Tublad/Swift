
import UIKit


class LiKeButton: UIButton {
    
    var liked: Bool = false {
        didSet {
            setupDefault()
        }
    }
    
    var likeCount: Int = 0 {
        didSet {
            setupDefault()
        }
    }
    
    func like() {
        liked = !liked
        if liked {
            setLiked()
        } else {
            disableLiked()
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
        setImage(UIImage(systemName: "heart"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        setTitleColor(liked ? UIColor.red : UIColor.gray, for: .normal)
        tintColor = liked ? .red : .gray
    }
    
    private func setLiked() {
        likeCount += 1
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        setTitleColor(UIColor.red, for: .normal)
        tintColor = .red
        animationLike()
    }
    
    private func disableLiked() {
        likeCount -= 1
        setImage(UIImage(systemName: "heart"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        tintColor = .gray
        animationLike()
    }
    
    private func animationLike() {
          let animation = CASpringAnimation(keyPath: "transform.scale")
          animation.fromValue = 1.2
          animation.toValue = 1
          animation.stiffness = 400
          animation.mass = 1
          animation.duration = 2
          layer.add(animation, forKey: nil)
      }
    
}
