import UIKit

class ProfileFriendCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    
    var imageCliced: ((UIView) -> ())? = nil
    
    override func awakeFromNib() {
        friendPhoto.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func pickImage() {
        imageCliced?(friendPhoto)
    }
    
}
