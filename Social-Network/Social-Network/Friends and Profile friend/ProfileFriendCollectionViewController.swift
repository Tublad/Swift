
import UIKit

class ProfileFriendCollectionViewController: UICollectionViewController, ImageViewerPresenterSource {
    
    var user: Friends?
    var photoUsers: [String]!
    var photoUser = [UIImage]()
    var source: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationBar()
        
        photoUsers = ["image1", "image2", "image3", "image4","image1", "image2", "image3", "image4","image1", "image2", "image3", "image4","image1", "image2", "image3", "image4"]
        photoUser = [UIImage(named: "image1")!, UIImage(named: "image2")!,UIImage(named: "image3")!, UIImage(named: "image4")!,UIImage(named: "image1")!, UIImage(named: "image2")!,UIImage(named: "image3")!, UIImage(named: "image4")!,UIImage(named: "image1")!, UIImage(named: "image2")!,UIImage(named: "image3")!, UIImage(named: "image4")!,UIImage(named: "image1")!, UIImage(named: "image2")!,UIImage(named: "image3")!, UIImage(named: "image4")!]
        
        self.title = "Фотографии"
    }
    
    func updateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFriendCell", for: indexPath) as? ProfileFriendCell else {
            return UICollectionViewCell()
        }
        
        cell.friendPhoto.image = UIImage(named: photoUsers[indexPath.item])
        
        cell.imageCliced = { view in
            self.source = view
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
          guard let vc = storyboard.instantiateViewController(identifier: "PreviewViewController") as? PreviewViewController else { return }
            vc.image = cell.friendPhoto.image
            let delegate = ImageViewerPresenter(delegate: self)
            self.navigationController?.delegate = delegate
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
}


