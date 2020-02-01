
import UIKit
import Kingfisher
import RealmSwift

class GroupTableViewController: UITableViewController {
    
   // var groupList = [Group]()
    var vkApi = VKApi()
    var database = GroupsRepository()
    
    var groupResults: Results<GroupRealm>!
    var token: NotificationToken?
    
    var customRefreshController = UIRefreshControl()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredGroup: [GroupRealm]!
    
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
        addSearchBarControl()
        addRefreshController()
        showGroups()
        getGroupsApi()
    }
    
    func showGroups() {
        do {
          //  groupList = Array(try database.getAll()).map { $0.toModel() }
            
            groupResults = try database.getAll()
            
            token = groupResults.observe { results in
                switch results {
                case .error(let error):
                    print(error)
                    break
                case .initial(let groups):
                    self.tableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self.tableView.endUpdates()
                }
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: запрос на список групп пользователя
    func getGroupsApi() {
        vkApi.getGroups(token: Session.shared.token) { [weak self] groups in
            switch groups {
            case .failure(let error):
                print(error)
            case .success(let group):
               // self?.groupList = group
                self?.database.addGroups(groups: group)
               // self?.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: настройки и добавление SearchBar
    func addSearchBarControl() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    // MARK: настройки и добавление RefreshController
    
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
    
    // MARK: действией на добавление группы из глобального поиска
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            /*
            guard let globalGroupController = segue.source as? GlobalGroupTableViewController else {
                return
            }
           if let indexPath = globalGroupController.tableView.indexPathForSelectedRow {
                
                let group: Group = globalGroupController.globalGroupList[indexPath.row]
                if !groupResults.contains(where: { (element) -> Bool in
                    if group.name == element.name {
                        return true
                    } else {
                        return false
                    }}){
                    groupResults.realm?.add(group)
                    tableView.reloadData()
                }
            }*/
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        token?.invalidate()
    }
}

// MARK: delegate

extension GroupTableViewController {
    
 /*   override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action,index)  in
            if self.isFiltering {
                self.filteredGroup.realm?.delete(self.groupResults[indexPath.row])
            } else {
                self.groupResults.realm?.delete(self.groupResults[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }
    */
}

// MARK: dataSource

extension GroupTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroup.count
        }
        return groupResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell",
                                                       for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        var group: GroupRealm
        if isFiltering {
            group = filteredGroup[indexPath.row]
        } else {
            group = groupResults[indexPath.row]
        }
        
        if group.imageGroup.isEmpty {
            cell.imageGroup.image = UIImage(named: "PhotoProfile")
        } else {
            let url = URL(string: String(group.imageGroup))
            cell.imageGroup.kf.setImage(with: url)
        }
        
        cell.groupName.text = group.name
        cell.content.text = group.content
        
        if group.content == "Открытая группа" {
            cell.participant.text = String(group.participant) + " участника"
        } else {
            cell.participant.text = String(group.participant) + " подписчика"
        }
        
        return cell
    }
    
}
// MARK: расширение TableView для SearchBar

extension GroupTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, indexPath: IndexPath.init())
    }
    
    private func filterContentForSearchText(_ searchText: String, indexPath: IndexPath) {
        filteredGroup = Array(groupResults).filter({ (group: GroupRealm ) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
