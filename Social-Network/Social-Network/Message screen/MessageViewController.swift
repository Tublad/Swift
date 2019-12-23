
import UIKit


class MessageViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    // сделал на время заглушки, чтоб отобразить их
    var friendListMessage = [Friends]()
    let navigatorAnimator = CustomNavigationControllerAnimation()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredMessage = [Friends]()
    
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
        addFriendList()
        addSearchBarControl()
        
        navigationController?.delegate = navigatorAnimator
    }
    
    func addSearchBarControl() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    func addFriendList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let profileViewController = storyboard.instantiateViewController(identifier: "FriendTableViewController") as? FriendTableViewController else {
            return 
        }
        friendListMessage = profileViewController.friendList
    }
    
    
    @IBAction func nextAnimationView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let privateView = storyboard.instantiateViewController(identifier: "PrivateMessage")
        navigationController?.pushViewController(privateView, animated: true)
    }
    
}

extension MessageViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, indexPath: IndexPath.init())
    }
    
    private func filterContentForSearchText(_ searchText: String, indexPath: IndexPath) {
        filteredMessage = friendListMessage.filter({ (friend: Friends) -> Bool in
            return friend.firstName.lowercased().contains(searchText.lowercased()) || friend.lastName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
}

extension MessageViewController { // dataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMessage.count
        }
        return friendListMessage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageScreenCell else {
            return UITableViewCell()
        }
        var messageList: Friends
        if isFiltering {
            messageList = filteredMessage[indexPath.row]
        } else {
            messageList = friendListMessage[indexPath.row]
        }
        
        cell.fullNameChat.text = messageList.firstName + " " + messageList.lastName
        cell.imageChat.image = UIImage(named: messageList.imageFriend)
        cell.imageUsers.image = UIImage(named: messageList.imageFriend)
        cell.textUser.text = messageList.message.textUser
        cell.timeMessage.text =  messageList.message.time
        var image: String
        if messageList.isOnline == true {
            image = "onlineFriend"
        } else {
            image = " "
        }
        cell.isOnlineImage.image = UIImage(named: image)
        
        return cell
    }
    
}

extension MessageViewController { // delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action,index)  in
            if self.isFiltering {
                let friend = self.filteredMessage.remove(at: indexPath.row)
                var indexes = 0
                for element in self.friendListMessage {
                    if element.firstName == friend.firstName {
                        self.friendListMessage.remove(at: indexes)
                        break
                    }
                    indexes += 1
                }
            } else {
                self.friendListMessage.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }
    
}
/*
 получилось реализовать, по заданию 1, но... Не совсем корректно работает )) Не могу понять почему..
 */

class CustomNavigationControllerAnimation: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop: return FadePopAnimation()
        case .push: return FadePushAnimation()
        case .none: return nil
        }
    }
}

class FadePushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        let π = CGFloat(M_PI)
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2)
        
        toVC.view.transform = offScreenRotateOut
        
        toVC.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromVC.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        toVC.view.layer.position = CGPoint(x: 0, y: 0)
        fromVC.view.layer.position = CGPoint(x: 0, y: 0)
    
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.addSubview(fromVC.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.49,
                       initialSpringVelocity: 0.81 ,
                       animations: {
                        
                fromVC.view.transform = offScreenRotateIn
            
            toVC.view.transform = CGAffineTransform.identity
        }) { finished in
            transitionContext.completeTransition(true)
        }
    }
}

class FadePopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        let π = CGFloat(M_PI)
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2 )
        
        toVC.view.transform = offScreenRotateIn
        
        toVC.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromVC.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        toVC.view.layer.position = CGPoint(x: 0, y: 0)
        fromVC.view.layer.position = CGPoint(x: 0, y: 0)
        
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.addSubview(fromVC.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.49,
                       initialSpringVelocity: 0.81 ,
                       animations: {
                        
            fromVC.view.transform = offScreenRotateOut
            
            toVC.view.transform = CGAffineTransform.identity
        }) { finished in
            transitionContext.completeTransition(true)
        }
    }
    
}
