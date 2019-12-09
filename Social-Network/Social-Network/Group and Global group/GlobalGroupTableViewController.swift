
import UIKit

class GlobalGroupTableViewController: UITableViewController {
    
    
    var globalGroupList: [Group] = [Group(name: "M.Game", content: "Открытая группа", participant: "65 865 участников", imageGroup: "PhotoGroup"),
                                    Group(name: "myPlayStation", content: "Видеоигры", participant: "87 782 подписчика", imageGroup: "PhotoGroup"),
                                    Group(name: "ADCI Solutions", content: "Веб-студия", participant: "1 388 подписчиков", imageGroup: "PhotoGroup"),
                                    Group(name: "ЧерньИла | Тату-Мастерская", content: "Открытая группа", participant: "3 486 участников",imageGroup: "PhotoGroup"),
                                    Group(name: "Заброшенное", content: "Туризм, путешествия", participant: "3 070 914 подписчиков",imageGroup: "PhotoGroup")]
    
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
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroup.count
        }
        return globalGroupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as! GlobalGroupCell
        
        var global: Group
        if isFiltering {
            global = filteredGroup[indexPath.row]
        } else {
            global = globalGroupList[indexPath.row]
        }
        
        
        cell.globalGroupName.text = global.name
        cell.globalContent.text = global.content
        cell.participantGlobal.text = global.participant
        cell.imageGlobal.image = UIImage(named: global.imageGroup )
        return cell
    }
    
}

extension GlobalGroupTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, indexPath: IndexPath.init())
    }
    
    private func filterContentForSearchText(_ searchText: String, indexPath: IndexPath) {
        filteredGroup = globalGroupList.filter({ (global: Group) -> Bool in
            return global.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
