
import UIKit
import Kingfisher

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
        vkApi.getPhotos(token: Session.shared.token, userId: String(id)) { [weak self] photo in
            switch photo {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self?.photoArray = photos
                self?.collectionView.reloadData()
            }
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
        
        let urls = URL(string:(photoArray[indexPath.row].url))
        cell.friendPhoto.kf.indicatorType = .activity
        cell.friendPhoto.kf.setImage(with: urls)
        
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


