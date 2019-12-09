
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
    
}
