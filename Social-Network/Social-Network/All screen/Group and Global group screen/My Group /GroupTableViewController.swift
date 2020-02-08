
import UIKit
import Kingfisher
import RealmSwift

class GroupTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: GroupsPresenter?
    var configurator: GroupConfigurator?
    var repository: GroupSource?
    
    var customRefreshController = UIRefreshControl()
    
    
    override func viewDidLoad() {
        configurator = GroupConfiguratorImplementation()
        configurator?.configure(view: self)
        
        searchBar.delegate = self
        addRefreshController()
        presenter?.viewDidLoad()
    }
    
    // MARK: настройки и добавление SearchBar
    
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
                
                guard let group: Group = globalGroupController.presenter?.modelAtIndexSearch(indexPath: indexPath) else { return }
                if (presenter?.checkGroup(id: group.id))! {
                    presenter?.addGroup(group: group)
                }
            }
        }
    }
}

// MARK: delegate

extension GroupTableViewController {
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action,index)  in
            self.presenter?.deleteGroup(indexPath: indexPath)
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
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell",
                                                       for: indexPath) as? GroupCell,
            let groups = presenter?.modelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        cell.renderCell(model: groups)
        return cell
    }
    
}

extension GroupTableViewController: UpdateView {
    func updateView() {
        tableView.reloadData()
    }
}
// MARK: расширение TableView для SearchBar

extension GroupTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchGroup(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}

