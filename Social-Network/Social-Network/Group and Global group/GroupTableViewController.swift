
import UIKit
import Kingfisher

class GroupTableViewController: UITableViewController {
    
    var groupList = [Group]()
    var vkApi = VKApi()
    
    var customRefreshController = UIRefreshControl()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredGroup = [Group]()
    
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
        
        // MARK: запрос на список групп пользователя
        
        vkApi.getGroups(token: Session.shared.token) { [weak self] groups in
            switch groups {
            case .failure(let error):
                print(error)
            case .success(let group):
                self?.groupList = group
                self?.tableView.reloadData()
            }
        }
        
        addSearchBarControl()
        addRefreshController()
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
            guard let globalGroupController = segue.source as? GlobalGroupTableViewController else {
                return
            }
            if let indexPath = globalGroupController.tableView.indexPathForSelectedRow {
                
                let group: Group = globalGroupController.globalGroupList[indexPath.row]
                if !groupList.contains(where: { (element) -> Bool in
                    if group.name == element.name {
                        return true
                    } else {
                        return false
                    }}){
                    groupList.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
    
}

// MARK: delegate

extension GroupTableViewController {
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action,index)  in
            if self.isFiltering {
                let group = self.filteredGroup.remove(at: indexPath.row)
                var indexes = 0
                for element in self.groupList {
                    if element.name == group.name {
                        self.groupList.remove(at: indexes)
                        break
                    }
                    indexes += 1
                }
            } else {
                self.groupList.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }
    
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
        return groupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell",
                                                       for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        var group: Group
        if isFiltering {
            group = filteredGroup[indexPath.row]
        } else {
            group = groupList[indexPath.row]
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
        filteredGroup = groupList.filter({ (group: Group) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
