import UIKit

class PreviewViewController: UIViewController {
     
    @IBOutlet weak var fullPhoto: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullPhoto.image = image
        fullPhoto.setupImageViewer()
    }
    
}



