
import UIKit
import Kingfisher

struct Section<T> {
    var title: String
    var item: [T]
}


class FriendTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var source: UIView?
    var friendList = [Friend]()
    var vkApi = VKApi()
    var friendSection = [Section<Friend>]()
    var database = FriendsRepository()
    
    var customRefreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        searchBar.delegate = self
        updateNavigationBar()
        addRefreshController()
        
        showFriends()
        getFriendListApi()
        
    }
    
    func showFriends() {
        do {
            friendList = Array(try database.getAll()).map { $0.toModel() }
            let friendDictionary = Dictionary.init(grouping: friendList) {
                $0.lastName.prefix(1)
            }
            friendSection = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
            friendSection.sort { $0.title < $1.title }
        } catch {
            print(error)
        }
    }
    
    
    // MARK: запрос на список друзей и сортировка по первой букве фамилии
    func getFriendListApi() {
        vkApi.getFriendList(token: Session.shared.token) { [weak self] friend in
            switch friend {
            case .failure(let error):
                print(error)
            case .success(let friends):
                self?.friendList = friends
                self?.database.addFriends(friend: friends)
                let friendDictionary = Dictionary.init(grouping: friends) {
                    $0.lastName.prefix(1)
                }
                self?.friendSection = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
                self?.friendSection.sort { $0.title < $1.title }
                
            }
            self?.tableView.reloadData()
        }
        
    }
    
    // MARK: добавление RefreshControllers
    
    func addRefreshController() {
        customRefreshController.tintColor = .white
        customRefreshController.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(customRefreshController)
    }
    
    @objc func refreshTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tableView.reloadData()
            self.customRefreshController.endRefreshing()
        }
    }
    // MARK: коррекция NavigationBar
    func updateNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}

// MARK: delegate

extension FriendTableViewController {
    
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

// MARK: dataSource

extension FriendTableViewController {
    
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
        
        if friend.avatar.isEmpty {
            cell.photoFriend.image = UIImage(named: "PhotoProfile")
        } else {
            cell.photoFriend.kf.indicatorType = .activity
            let url = URL(string: String(friend.avatar))
            cell.photoFriend.kf.setImage(with: url)
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

// MARK: Расширешие для SearchBar 

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
