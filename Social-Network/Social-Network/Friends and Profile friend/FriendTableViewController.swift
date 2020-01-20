

import UIKit
import Kingfisher

struct Section<T> {
    var title: String
    var item: [T]
}


class FriendTableViewController: UITableViewController, ImageViewerPresenterSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var source: UIView?
    var friendList = [Friends]()
    var vkApi = VKApi()
    var friendSection = [Section<Friends>]()
    
    override func viewDidLoad() {
        searchBar.delegate = self
        updateNavigationBar()
        
        
        vkApi.getFriendList(token: Session.shared.token) { (friends) in
            self.friendList = friends
            let friendDictionary = Dictionary.init(grouping: friends) {
                $0.lastName.prefix(1)
            }
            self.friendSection = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
            self.friendSection.sort { $0.title < $1.title }
            self.tableView.reloadData()
        }
        
    }
    
    func updateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}

extension FriendTableViewController { // delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = friendSection[indexPath.section].item[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let ProfileFriendCollectionView = storyboard.instantiateViewController(identifier: "ProfileFriendCollectionViewController") as? ProfileFriendCollectionViewController else {
            return
        }
        
        ProfileFriendCollectionView.user = userName
        self.navigationController?.pushViewController(ProfileFriendCollectionView, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action, index) in
            self.friendList.removeAll {
                $0.firstName == self.friendSection[indexPath.section].item[indexPath.row].firstName
            }
            self.tableView.reloadData()
        }
        return [deleteAction]
    }
}

extension FriendTableViewController { // dataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendSection[section].item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        
        let friend = friendSection[indexPath.section].item[indexPath.row]
        
        cell.nameFriend.text = friend.firstName + " " + friend.lastName
        var image: String
        if friend.online == 1 {
            image = "onlineFriend"
        } else {
            image = " "
        }
        var photos = [Photo]()
        
        vkApi.getPhotos(token: Session.shared.token, userId: String(friend.id)) { (photo) in
            photos = photo
            
            if photos.isEmpty {
                cell.photoFriend.image = UIImage(named: "PhotoProfile")
            } else {
                let url = URL(string: String(photos[0].url))
                cell.photoFriend.kf.indicatorType = .activity
                cell.photoFriend.kf.setImage(with: url)
            }
        }
        cell.isOnline.image = UIImage(named: image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section].title
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSection.map { $0.title  }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}

extension FriendTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendDictionary = Dictionary(grouping: friendList.filter({ (friend) -> Bool in
            return searchText.isEmpty ? true : friend.firstName.lowercased().contains(searchText.lowercased()) || friend.lastName.lowercased().contains(searchText.lowercased())
        })) {
            $0.lastName.prefix(1)
        }
        friendSection = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
        friendSection.sort { $0.title < $1.title }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}
