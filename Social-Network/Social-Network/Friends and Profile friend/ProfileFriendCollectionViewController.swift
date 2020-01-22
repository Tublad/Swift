
import UIKit
import Kingfisher
import ImageViewer_swift

class ProfileFriendCollectionViewController: UICollectionViewController {
    
    var user: Friends?
    var photoArray = [Photo]()
    var source: UIView?
    var vkApi = VKApi()
    let imageCache = NSCache<NSString, UIImage>()
    var images = [String]()
    
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
                for value in photos {
                    self?.images.append(value.url)
                }
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
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFriendCell", for: indexPath) as? ProfileFriendCell else {
            return UICollectionViewCell()
        }
        
        let imageString = self.images[indexPath.row]
        cell.friendPhoto.kf.indicatorType = .activity
        if let imageUrl = URL(string: imageString) {
            cell.friendPhoto.kf.setImage(with: imageUrl)
        } else {
            cell.friendPhoto.image = UIImage()
        }
      
        
        cell.friendPhoto.setupImageViewer(urls: images.map{ URL(string: $0)! },
                                          initialIndex: indexPath.row,
                                          options: [.theme(.dark)])
        
        return cell
    }
    
}


