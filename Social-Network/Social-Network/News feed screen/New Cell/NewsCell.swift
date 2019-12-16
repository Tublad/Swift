
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
    @IBOutlet weak var animationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeNewsAction(_ sender: Any) {
        guard let liked = (sender as? LiKeButton) else {
            return
        }
        liked.like()
        animationLike()
    }
    
    @IBAction func commentNewsButton(_ sender: Any) {
        guard let commented = (sender as? CommintButton) else {
                   return
               }
        commented.commet()
        animationCommit()
    }
    @IBAction func repostNewsButton(_ sender: Any) {
        guard let reposted = (sender as? RepostButton) else {
                   return
               }
        reposted.repost()
        animationRepost()
    }
    @IBAction func animationImageView(_ sender: Any) {
        animationImage()
    }
    
    func animationRepost() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.repostNew.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.repostNew.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })})
    }
    
    func animationCommit() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.commintNew.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.commintNew.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })})
    }
    
    func animationLike() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.likeNews.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.likeNews.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })})
    }
    
    func animationImage() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.newsImage.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.newsImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })})
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
