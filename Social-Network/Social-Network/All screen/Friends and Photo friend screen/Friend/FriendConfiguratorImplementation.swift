
import UIKit

//MARK: use Configuration for FriendTableViewController

protocol FriendConfigurator {
    func configure(view: FriendTableViewController)
}

class FriendConfiguratorImplementation: FriendConfigurator {
    func configure(view: FriendTableViewController) {
        view.presenter = FriendsPresenterImplementation(database: FriendsRepository(),
                                                        view: view)
    }
}
