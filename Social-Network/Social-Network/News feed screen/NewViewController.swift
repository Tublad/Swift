
import UIKit

class NewsViewController: UITableViewController {
    
    var news = [Friends]()
    var customRefreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "simpleNewsCell")
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        addFriendList()
        addRefreshController()
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
    
    func addFriendList() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           guard let profileViewController = storyboard.instantiateViewController(identifier: "FriendTableViewController") as? FriendTableViewController else {
               return
           }
       }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return news.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "simpleNewsCell", for: indexPath) as? NewsCell  else {
            return UITableViewCell()
        }
        
        cell.nameGroup.text = news[indexPath.row].firstName + " " + news[indexPath.row].lastName
        
        
        return cell
    }
    
}
