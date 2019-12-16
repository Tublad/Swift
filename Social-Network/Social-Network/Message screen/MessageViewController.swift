
import UIKit


class MessageViewController: UITableViewController {
    
    // сделал на время заглушки, чтоб отобразить их
    var friendListMessage = [Friends]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredMessage = [Friends]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendList()
        addSearchBarControl()
    }
    
    func addSearchBarControl() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    func addFriendList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let profileViewController = storyboard.instantiateViewController(identifier: "FriendTableViewController") as? FriendTableViewController else {
            return 
        }
        friendListMessage = profileViewController.friendList
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMessage.count
        }
        return friendListMessage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageScreenCell else {
            return UITableViewCell()
        }
        var messageList: Friends
        if isFiltering {
            messageList = filteredMessage[indexPath.row]
        } else {
            messageList = friendListMessage[indexPath.row]
        }
        
        cell.fullNameChat.text = messageList.firstName + " " + messageList.lastName
        cell.imageChat.image = UIImage(named: messageList.imageFriend)
        cell.imageUsers.image = UIImage(named: messageList.imageFriend)
        cell.textUser.text = messageList.message.textUser
        cell.timeMessage.text =  messageList.message.time
        var image: String
        if messageList.isOnline == true {
            image = "onlineFriend"
        } else {
            image = " "
        }
        cell.isOnlineImage.image = UIImage(named: image)
        
        return cell
    }
    
    @IBAction func nextAnimationView(_ sender: Any) {
        performSegue(withIdentifier: "animationView", sender: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action,index)  in
            if self.isFiltering {
                let friend = self.filteredMessage.remove(at: indexPath.row)
                var indexes = 0
                for element in self.friendListMessage {
                    if element.firstName == friend.firstName {
                        self.friendListMessage.remove(at: indexes)
                        break
                    }
                    indexes += 1
                }
            } else {
                self.friendListMessage.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }
    
}

extension MessageViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
       filterContentForSearchText(searchController.searchBar.text!, indexPath: IndexPath.init())
    }

    private func filterContentForSearchText(_ searchText: String, indexPath: IndexPath) {
        filteredMessage = friendListMessage.filter({ (friend: Friends) -> Bool in
            return friend.firstName.lowercased().contains(searchText.lowercased()) || friend.lastName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
 
}

