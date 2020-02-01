
import UIKit
import RealmSwift

// MARK: use Presenter for FriendsViewController

protocol FriendsPresenter {
    func viewDidLoad()
    func searchFriend(name: String)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func modelAtIndex(indexPath: IndexPath) -> FriendRealm?
    func titleForInSection(_ section: Int) -> String?
    func sectionIndexTitles() -> [String]?
    func willDisplayHeaderView(view: UIView, section: Int)
}

class FriendsPresenterImplementation: FriendsPresenter {

    private var vkApi: VKApi
    private var database: FriendSource
    
    private var token: NotificationToken?
    
    private var friendsResults: Results<FriendRealm>!
    private var sortedFriendsResults = [Section<FriendRealm>]()
    
    private weak var view: FriendUpdateView?
    
    init(database: FriendSource, view: FriendUpdateView) {
        vkApi = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad() {
        getUsersFromDatabase()
        getUsersFromApi()
    }
    
    func searchFriend(name: String) {
        let friendDictionary = Dictionary(grouping: friendsResults.filter({ (friend) -> Bool in
            return name.isEmpty ? true : friend.firstName.lowercased().contains(name.lowercased()) || friend.lastName.lowercased().contains(name.lowercased())
        })) {
            $0.lastName.prefix(1)
        }
        sortedFriendsResults = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
        sortedFriendsResults.sort { $0.title < $1.title }
        view?.updateTable()
    }
    
    private func getUsersFromDatabase() {
        do {
            friendsResults = try database.getAll()
    
            let friendDictionary = Dictionary.init(grouping: friendsResults) {
                $0.lastName.prefix(1)
            }
            sortedFriendsResults = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
            sortedFriendsResults.sort { $0.title < $1.title }
            view?.updateTable()
        } catch {
            print(error)
        }
    }
    
    private func getUsersFromApi() {
        vkApi.getFriendList(token: Session.shared.token) { [weak self] friend in
            switch friend {
            case .failure(let error):
                print(error)
            case .success(let friends):
                self?.database.addFriends(friends: friends)
                self?.getUsersFromDatabase()
            }
        }
    }
    
}

extension FriendsPresenterImplementation {
    
    func numberOfSections() -> Int {
        return sortedFriendsResults.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sortedFriendsResults[section].item.count
    }
    
    func modelAtIndex(indexPath: IndexPath) -> FriendRealm? {
        return sortedFriendsResults[indexPath.section].item[indexPath.row]
    }
    
    func titleForInSection(_ section: Int) -> String? {
        return sortedFriendsResults[section].title
    }
    
    func sectionIndexTitles() -> [String]? {
       return sortedFriendsResults.map { $0.title  }
    }
    
    func willDisplayHeaderView(view: UIView, section: Int) {
        view.tintColor = UIColor.clear
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}
