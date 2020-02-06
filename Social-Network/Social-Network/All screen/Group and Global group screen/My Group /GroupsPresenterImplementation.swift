

import Foundation
import RealmSwift

protocol GroupsPresenter {
    func viewDidLoad()
    func searchGroup(name: String)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func modelAtIndex(indexPath: IndexPath) -> GroupRealm?
    
}

class GroupsPresenterImplementation: GroupsPresenter {
    
    private var vkApi: VKApi
    private var database: GroupSource
    
    private var groupResults: Results<GroupRealm>!
    private var sortedFriendsResults: [GroupRealm] = []
    
    func viewDidLoad() {
        getGroupFromDatabase()
        getGroupsApi()
    }
    
    init(database: GroupSource) {
        vkApi = VKApi()
        self.database = database
    }
    
    func searchGroup(name: String) {
        sortedFriendsResults = groupResults.filter({ (group: GroupRealm) -> Bool in
            return group.name.lowercased().contains(name.lowercased())
        })
    }
    
    func getGroupFromDatabase() {
        do {
            groupResults = try database.getAll()
        } catch {
            print(error)
        }
    }
    
    func getGroupsApi() {
        vkApi.getGroups(token: Session.shared.token) { [weak self] groups in
            switch groups {
            case .failure(let error):
                print(error)
            case .success(let group):
                self?.database.addGroups(groups: group)
                self?.getGroupFromDatabase()
            }
        }
        
    }
}

extension GroupsPresenterImplementation {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return groupResults.count
    }
    
    func modelAtIndex(indexPath: IndexPath) -> GroupRealm? {
        return groupResults[indexPath.row]
    }
}

