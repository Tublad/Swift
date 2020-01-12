import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet private weak var imageViewPreview: UIImageView!
    
    var correctlyPhoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
    }
    
    func updateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imageViewPreview.image = correctlyPhoto
    }
}
