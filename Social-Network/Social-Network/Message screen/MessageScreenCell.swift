
import UIKit

class MessageScreenCell: UITableViewCell {
    

    @IBOutlet weak var fullNameChat: UILabel!
    @IBOutlet weak var imageChat: UIImageView!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var imageUsers: UIImageView!
    @IBOutlet weak var textUser: UILabel!
    @IBOutlet weak var isOnlineImage: UIImageView!
    @IBOutlet weak var nextView: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
