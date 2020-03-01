
import UIKit
import Kingfisher
import ImageViewer_swift

class PhotoFriendCollectionViewController: UICollectionViewController {
    
    var user: FriendRealm?
    var presenter: PhotoFriendPresenter?
    var configurator: PhotoConfiguration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
        configurator?.configure(view: self, user: user)
        
        presenter?.viewDidLoad()
        self.title = "Фотографии"
        
    }
    // MARK: расширение NavigationBar
    
    func updateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}

// MARK: dataSource

extension PhotoFriendCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFriendCell", for: indexPath) as? PhotoFriendCell,
            let model = presenter?.modelAtIndex(indexPath: indexPath),
            let photoArray = presenter?.getUrlArray() else {
                return UICollectionViewCell()
        }
        cell.renderCell(model: model)
        cell.friendPhoto.setupImageViewer(urls: photoArray, initialIndex: indexPath.item, options: [.theme(.dark)])
        return cell
    }
}

extension PhotoFriendCollectionViewController: UpdateView {
    func updateView() {
        collectionView.reloadData()
    }
}
