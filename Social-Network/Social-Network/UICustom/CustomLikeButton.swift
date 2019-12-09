
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
        setImage(UIImage(named: "like" ), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = liked ? .red : .gray
    }
    
    private func setLiked() {
        likeCount += 1
        setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .red
    }
    
    private func disableLiked() {
        likeCount -= 1
        setImage(UIImage(named: "disLike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .gray
    }
    
}
