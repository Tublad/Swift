
import UIKit
import Kingfisher
import RealmSwift

struct Section<T> {
    var title: String
    var item: [T]
}

protocol UpdateView: class {
    func updateView()
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

extension FriendTableViewController {
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let photoFriendCollectionView = storyboard.instantiateViewController(identifier: "PhotoFriendCollectionViewController") as? PhotoFriendCollectionViewController else {
            return
        }
        photoFriendCollectionView.user = presenter?.getSortedUser(indexPath: indexPath)
        photoFriendCollectionView.configurator = PhotoConfigurationImplementation()
        self.navigationController?.pushViewController(photoFriendCollectionView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action, index) in
               // Hmmmmmm fix me =)
            
            self.tableView.reloadData()
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

extension FriendTableViewController: UpdateView {
    func updateView() {
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
