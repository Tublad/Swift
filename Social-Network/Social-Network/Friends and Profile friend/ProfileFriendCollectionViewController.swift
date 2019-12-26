
import UIKit


class ProfileFriendCollectionViewController: UICollectionViewController {
    
    var user: Friends?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationBar()
    }
    
    func updateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func likedButton(_ sender: Any) {
        guard let liked = (sender as? LiKeButton) else {
            return
        }
        liked.like()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFriendCell", for: indexPath) as? ProfileFriendCell else {
            return UICollectionViewCell()
        }
        guard let image = user?.imageFriend else { return UICollectionViewCell() }
        cell.friendPhoto.image = UIImage(named: image)
        
        return cell
    }
    
}
