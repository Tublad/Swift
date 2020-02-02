
import UIKit
import Kingfisher
import ImageViewer_swift

protocol ProfileViewUpdate: class {
    func updateView()
}

class ProfileFriendCollectionViewController: UICollectionViewController {
    
    var user: FriendRealm?
    var presenter: ProfileFriendPresenter?
    var configurator: ProfileConfiguration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
        configurator?.configure(view: self)
        
        presenter?.user = user
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

extension ProfileFriendCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFriendCell", for: indexPath) as? ProfileFriendCell,
              let model = presenter?.modelAtIndex(indexPath: indexPath) else {
                return UICollectionViewCell()
        }
        cell.renderCell(model: model)
        return cell
    }
    
}

extension ProfileFriendCollectionViewController: ProfileViewUpdate {
    func updateView() {
        collectionView.reloadData()
    }
}
