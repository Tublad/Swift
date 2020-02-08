
import UIKit

class GlobalGroupCell: UITableViewCell {
    @IBOutlet weak var globalGroupName: UILabel!
    @IBOutlet weak var imageGlobal: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func renderCell(model: Group) {
        globalGroupName.text = model.name
        
        if model.imageGroup.isEmpty {
            imageGlobal.image = UIImage(named: "PhotoProfile")
        } else {
            let url = URL(string: String(model.imageGroup))
            imageGlobal.kf.setImage(with: url)
        }
    }
    
}
