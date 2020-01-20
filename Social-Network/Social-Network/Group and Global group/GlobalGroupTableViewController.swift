
import UIKit
import Kingfisher

class GlobalGroupTableViewController: UITableViewController {
    
    var customRefreshController = UIRefreshControl()
    
    var globalGroupList = [Group]()
    var vkApi = VKApi()
    
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
}

extension GlobalGroupTableViewController { // dataSource
    
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
        
        if global.imageGroup.isEmpty {
            cell.imageGlobal.image = UIImage(named: "PhotoProfile")
        } else {
            let url = URL(string: String(global.imageGroup))
            cell.imageGlobal.kf.setImage(with: url)
        }
        
        return cell
    }
}

extension GlobalGroupTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, indexPath: IndexPath.init())
    }
    
    private func filterContentForSearchText(_ searchText: String, indexPath: IndexPath) {
        vkApi.getGroupsSearch(token: Session.shared.token, name: searchText.lowercased()) { (global) in
            self.globalGroupList = global
            self.filteredGroup = self.globalGroupList.filter({ (global: Group) -> Bool in
                return global.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}
