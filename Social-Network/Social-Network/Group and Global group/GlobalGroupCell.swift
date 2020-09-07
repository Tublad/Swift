
import UIKit

class GlobalGroupCell: UITableViewCell {
    @IBOutlet weak var globalGroupName: UILabel!
    @IBOutlet weak var globalContent: UILabel!
    @IBOutlet weak var participantGlobal: UILabel!
    @IBOutlet weak var imageGlobal: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
