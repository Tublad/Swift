
import UIKit
import Kingfisher

class GlobalGroupTableViewController: UITableViewController {
    
    var customRefreshController = UIRefreshControl()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: GlobalGroupsPresenter?
    var configurator: GlobalGroupsConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator = GlobalGroupsConfigurationImplementation()
        configurator?.configurator(view: self)
        
        addRefreshController()
        searchBar.delegate = self
        settingFooter()
        presenter?.viewDidLoad()
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
    
    private func settingFooter() {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footerView
    }
}

// MARK: dataSource

extension GlobalGroupTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSectionSearch() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as? GlobalGroupCell,
            let globalSearchList = presenter?.modelAtIndexSearch(indexPath: indexPath) else { return UITableViewCell() }
        
        let global: Group = globalSearchList
        
        cell.renderCell(model: global)
        
        return cell
    }
}

// MARK: Расширение для SearchBar

extension GlobalGroupTableViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchGroup(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}

extension GlobalGroupTableViewController: UpdateView {
    func updateView() {
        tableView.reloadData()
    }
}
