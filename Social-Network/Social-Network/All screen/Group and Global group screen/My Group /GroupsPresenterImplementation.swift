import Foundation
import RealmSwift

protocol GroupsPresenter {
    func viewDidLoad()
    func searchGroup(name: String)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func modelAtIndex(indexPath: IndexPath) -> GroupRealm?
    func deleteGroup(indexPath: IndexPath)
    func checkGroup(id: Int) -> Bool
    func addGroup(group: Group)
}

class GroupsPresenterImplementation: GroupsPresenter {
    
    private var vkApi: VKApi
    private var database: GroupSource
    
    private weak var view: UpdateView?
    
    private var groupResults: Results<GroupRealm>!
    private var sortedGroupsResults = [GroupRealm]()
    
    func viewDidLoad() {
        getGroupFromDatabase()
        getGroupsApi()
    }
    
    init(database: GroupSource, view: UpdateView) {
        vkApi = VKApi()
        self.database = database
        self.view = view
    }
    
    func searchGroup(name: String) {
        sortedGroupsResults = Array(groupResults).filter{ (group: GroupRealm) -> Bool in
            return name.isEmpty ? true : group.name.lowercased().contains(name.lowercased())
        }
        view?.updateView()
    }
    
    private func getGroupFromDatabase() {
        do {
            groupResults = try database.getAll()
            sortedGroupsResults = Array(groupResults).sorted { (one, two) in
                one.name < two.name
            }
            view?.updateView()
        } catch {
            print(error)
        }
    }
    
    private func getGroupsApi() {
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
    
    func numberOfRowsInSection() -> Int {
        return sortedGroupsResults.count
    }
    
    func modelAtIndex(indexPath: IndexPath) -> GroupRealm? {
        return sortedGroupsResults[indexPath.row]
    }
    
    func deleteGroup(indexPath: IndexPath) {
        database.deleteGroup(id: sortedGroupsResults[indexPath.row].id)
        getGroupFromDatabase()
    }
    
    func checkGroup(id: Int) -> Bool {
        let group = database.getGroup(id: id)
        if group == nil{
            return true
        } else {
            return false
        }
    }
    
    func addGroup(group: Group) {
        database.addGroup(group: group)
        getGroupFromDatabase()
    }
}

