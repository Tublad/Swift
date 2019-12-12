
import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var aboutOfNews: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var repostNew: UIButton!
    @IBOutlet weak var commintNew: UIButton!
    @IBOutlet weak var likeNews: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeNewsAction(_ sender: Any) {
        guard let liked = (sender as? LiKeButton) else {
            return
        }
        liked.like()
    }
    @IBAction func commentNewsButton(_ sender: Any) {
        guard let commented = (sender as? CommintButton) else {
                   return
               }
        commented.commet()
    }
    @IBAction func repostNewsButton(_ sender: Any) {
        guard let reposted = (sender as? RepostButton) else {
                   return
               }
        reposted.repost()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
