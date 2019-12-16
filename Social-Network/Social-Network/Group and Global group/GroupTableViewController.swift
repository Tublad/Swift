
import UIKit

class GroupTableViewController: UITableViewController {
    
    var groupList: [Group] = [Group(name: "Сообщества Developed iOS", content: "Образовательный", participant: "2 312 105 участников", imageGroup: "PhotoGroup"),
                              Group(name: "PlayStation Store Official Group", content: "Видеоигры", participant: "201 123 участиков", imageGroup: "PhotoGroup"),
                              Group(name: "Паблик +100500", content: "Развлекательный", participant: "1 000 123 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Одежда из Европы", content: "Одежда", participant: "54 123 участников", imageGroup: "PhotoGroup"),
                              Group(name: "SwiftBook iOS", content: "Образовательный", participant: "14 120 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Лайфхакер", content: "Познавательный", participant: "5 103 участника", imageGroup: "PhotoGroup"),
                              Group(name: "Vine Video", content: "Юмор", participant: "5 231 214 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Grisha", content: "Кафе, Ресторан", participant: "6 012 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Английский каждый день", content: "Языки", participant: "99 124 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Rosberry - Mobile Apps", content: "Программное обеспечение", participant: "501 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Game park | Гейм парк", content: "Открытая группа", participant: "142 612 участников", imageGroup: "PhotoGroup"),
                              Group(name: "Dota 2 HS", content: "Видеоигры", participant: "3 123 412 участников", imageGroup: "PhotoGroup")]
    
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
        
        addSearchBarControl()
        addRefreshController()
    }
    
    
    func addSearchBarControl() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    func addRefreshController() {
        customRefreshController.tintColor = .white
        customRefreshController.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(customRefreshController)
    }
    
    @objc func refreshTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.customRefreshController.endRefreshing()
        }
    }
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        
        var group: Group
        if isFiltering {
            group = filteredGroup[indexPath.row]
        } else {
            group = groupList[indexPath.row]
        }
        
        cell.imageGroup.image = UIImage(named: group.imageGroup)
        cell.groupName.text = group.name
        cell.content.text = group.content
        cell.participant.text = group.participant
        
        return cell
    }
    
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
