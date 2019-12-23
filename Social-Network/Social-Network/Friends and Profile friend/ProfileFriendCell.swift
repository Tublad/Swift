import UIKit

class ProfileFriendCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var like: LiKeButton!
    
    @IBAction func likedButton(_ sender: Any) {
        guard let liked = (sender as? LiKeButton) else {
            return
        }
        liked.like()
    }
   
    /*  func animationOnline() {
        let customLayer = CAShapeLayer()
        
        customLayer.path = CGPath.init(roundedRect: friendPhoto.frame, cornerWidth: 3, cornerHeight: 30 , transform: nil)
         
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = customLayer.path
        followPathAnimation.duration = 5.0
        followPathAnimation.repeatCount = .infinity
        
        
        let onlineLayer = CAShapeLayer()
        onlineLayer.bounds = CGRect(x: 0, y: 0, width: 15, height: 30)
        onlineLayer.contents = UIImage(named: "onlineFriend")?.cgImage
        friendPhoto.layer.addSublayer(onlineLayer)
        
        onlineLayer.add(followPathAnimation, forKey: nil)
    } */
    
}
