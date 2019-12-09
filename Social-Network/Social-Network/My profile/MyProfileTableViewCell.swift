
import UIKit

class MyProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var MyPhotoImage: CustomPhoto!
    @IBOutlet weak var likeButton: LiKeButton!
    @IBOutlet weak var isOnlineLabel: UILabel!
    @IBOutlet weak var ageAndCity: UILabel!
    @IBOutlet weak var isOnlineImage: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
