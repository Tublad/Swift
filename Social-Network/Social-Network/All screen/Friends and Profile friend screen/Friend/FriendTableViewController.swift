
import UIKit
import Kingfisher

struct Section<T> {
    var title: String
    var item: [T]
}

protocol FriendUpdateView: class {
    func updateTable()
}


class FriendTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    var presenter: FriendsPresenter?
    var configurator: FriendConfigurator?
    var repository: FriendSource?
    
    var customRefreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        configurator = FriendConfiguratorImplementation()
        configurator?.configure(view: self)
        
        searchBar.delegate = self
        updateNavigationBar()
        addRefreshController()
        //MVP
        presenter?.viewDidLoad()
    }
    
    
    // MARK: запрос на список друзей и сортировка по первой букве фамилии
    
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
// Один смог сообразить как реазивать, а 2 метод(вылетал fatal error),надеюсь расскажите на след уроке как все исправить =)

extension FriendTableViewController {
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let ProfileFriendCollectionView = storyboard.instantiateViewController(identifier: "ProfileFriendCollectionViewController") as? ProfileFriendCollectionViewController else {
            return
        }
        ProfileFriendCollectionView.user = presenter?.getSortedUser(indexPath: indexPath)
        ProfileFriendCollectionView.configurator = ProfileConfigurationImplementation()
        self.navigationController?.pushViewController(ProfileFriendCollectionView, animated: true)
    }
    // c удалением совсем не понятно (((
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // let friendSection = presenter?.getSortedUser(indexPath: indexPath)
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action, index) in
            if let friendList = self.presenter?.getUserList(indexPath: indexPath) {
                self.repository?.deleteFriend(id: friendList.id)
                self.tableView.reloadData()
            }
        }
        return [deleteAction]
    }
}

// MARK: dataSource

extension FriendTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell,
            let model = presenter?.modelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        cell.renderCell(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.titleForInSection(section)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter?.sectionIndexTitles()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        presenter?.willDisplayHeaderView(view: view, section: section)
    }
}

extension FriendTableViewController: FriendUpdateView {
    func updateTable() {
        tableView.reloadData()
    }
}

// MARK: Расширешие для SearchBar 

extension FriendTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchFriend(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}
