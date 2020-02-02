import UIKit

class ProfileFriendCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    
    override func awakeFromNib() {
        
    }
    
    func renderCell(model: PhotoRealm) {
        let imageString = model.url
        
        friendPhoto.kf.indicatorType = .activity
        
        if let imageUrl = URL(string: imageString) {
            friendPhoto.kf.setImage(with: imageUrl)
        } else {
            friendPhoto.image = UIImage()
        }
        friendPhoto.setupImageViewer()
    }
    
}

