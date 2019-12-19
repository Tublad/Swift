
import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var photoFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var isOnline: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func animationImage() {
        let strokeLayer = CAShapeLayer()
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.strokeColor = UIColor.blue.cgColor
        strokeLayer.lineWidth = 3
        
        strokeLayer.path = CGPath(roundedRect: photoFriend.frame, cornerWidth: frame.size.width / 2, cornerHeight: frame.size.height / 2, transform: nil)
        photoFriend.layer.addSublayer(strokeLayer)
        
        let strokeAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        strokeAnimationStart.fromValue = 0
        strokeAnimationStart.toValue = 1.0
        
        let strokeAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimationEnd.fromValue = 0
        strokeAnimationEnd.toValue = 1.2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.5
        animationGroup.animations = [strokeAnimationEnd, strokeAnimationStart]
        animationGroup.autoreverses = true
        animationGroup.repeatCount = .infinity
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        
        strokeLayer.add(animationGroup, forKey: nil)
        
        layer.addSublayer(strokeLayer)
    }
    
}
