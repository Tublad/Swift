
import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var photoFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var isOnline: UIImageView!
    
    
    override func prepareForReuse() {
        photoFriend.image = nil
    }
    
    func renderCell(model: FriendRealm) {
        
        nameFriend.text = model.firstName + " " + model.lastName
        var image: String
        if model.online == 1 {
            image = "onlineFriend"
        } else {
            image = " "
        }
        
        if model.avatar.isEmpty {
            photoFriend.image = UIImage(named: "PhotoProfile")
        } else {
            photoFriend.kf.indicatorType = .activity
            let url = URL(string: String(model.avatar))
            photoFriend.kf.setImage(with: url)
        }
        isOnline.image = UIImage(named: image)
    }
}
