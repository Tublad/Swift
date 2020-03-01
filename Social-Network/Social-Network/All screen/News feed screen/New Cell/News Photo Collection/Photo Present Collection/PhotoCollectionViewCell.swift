
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIndefender = "PhotoCollectionCell"
    static var nib : UINib {
        return UINib(nibName: "PhotoCollectionCell", bundle: nil)
    }
    
    @IBOutlet weak var galleryPhoto: UIImageView!
    
    override func prepareForReuse() {
        galleryPhoto.image = nil
    }
}
