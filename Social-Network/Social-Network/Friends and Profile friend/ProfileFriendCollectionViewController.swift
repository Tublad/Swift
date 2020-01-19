
import UIKit

class ProfileFriendCollectionViewController: UICollectionViewController, ImageViewerPresenterSource {
    
    var user: Friends?
    var photoArray = [Photo]()
    var source: UIView?
    var vkApi = VKApi()
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationBar()
        guard let id = user?.id else {
            return
        }
        vkApi.getPhotos(token: Session.shared.token, userId: String(id)) { (photo) in
            self.photoArray = photo
            self.collectionView.reloadData()
        }
        
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
        return photoArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFriendCell", for: indexPath) as? ProfileFriendCell else {
            return UICollectionViewCell()
        }
       
        if let cachedImage = self.imageCache.object(forKey: NSString(string:(String(self.photoArray[indexPath.row].id)))) {
            cell.friendPhoto.image = cachedImage
        } else {
            DispatchQueue.global(qos: .background).async {
                let url = URL(string:(self.photoArray[indexPath.row].url))
                let data = try? Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data!)!
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: NSString(string: (String(self.photoArray[indexPath.row].id))))
                    cell.friendPhoto.image = image
                }
            }
        }
       
        
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


