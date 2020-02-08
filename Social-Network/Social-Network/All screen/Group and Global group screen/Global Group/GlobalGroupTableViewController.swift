
import UIKit
import Kingfisher

class GlobalGroupTableViewController: UITableViewController {
    
    var customRefreshController = UIRefreshControl()
    
    var presenter: GlobalGroupsPresenter?
    var configurator: GlobalGroupsConfiguration?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        
        configurator = GlobalGroupsConfigurationImplementation()
        configurator?.configurator(view: self)
        
        addSearchBarControl()
        addRefreshController()
        
        presenter?.viewDidLoad()
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
}

// MARK: dataSource

extension GlobalGroupTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return presenter?.numberOfRowsInSectionSearch() ?? 0
        }
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as? GlobalGroupCell,
            let globalList = presenter?.modelAtIndex(indexPath: indexPath),
            let globalSearchList = presenter?.modelAtIndexSearch(indexPath: indexPath) else { return UITableViewCell() }
        
        var global: Group
        if isFiltering {
            global = globalSearchList
        } else {
            global = globalList
        }
        
        cell.renderCell(model: global)
        
        return cell
    }
}

// MARK: Расширение для SearchBar

extension GlobalGroupTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, indexPath: IndexPath.init())
    }
    
    private func filterContentForSearchText(_ searchText: String, indexPath: IndexPath) {
        presenter?.searchGroup(name: searchText)
    }
}

extension GlobalGroupTableViewController: UpdateView {
    func updateView() {
        tableView.reloadData()
    }
}
