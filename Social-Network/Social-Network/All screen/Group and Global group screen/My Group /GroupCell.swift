
import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var imageGroup: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func renderCell(model: GroupRealm) {
        if model.imageGroup.isEmpty {
            imageGroup.image = UIImage(named: "PhotoProfile")
        } else {
            let url = URL(string: String(model.imageGroup))
            imageGroup.kf.setImage(with: url)
        }
        
        groupName.text = model.name
        content.text = model.content
    }

}
