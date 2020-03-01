
import Foundation
import RealmSwift

protocol GlobalGroupsPresenter {
    func viewDidLoad()
    func searchGroup(name: String)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func numberOfRowsInSectionSearch() -> Int
    func modelAtIndex(indexPath: IndexPath) -> Group?
    func modelAtIndexSearch(indexPath: IndexPath) -> Group?
}

class GlobalGroupsPresenterImplementation: GlobalGroupsPresenter {
    
    private var vkApi: VKApi
    
    private var globalGroupList = [Group]()
    private var filteredGroup = [Group]()
    
    private weak var view: UpdateView?
    
    func viewDidLoad() {
        getGlobalGroup()
    }
    
    init(view: UpdateView){
        vkApi = VKApi()
        self.view = view
    }
    
    func searchGroup(name: String) {
        vkApi.getGroupsSearch(token: Session.shared.token, name: name.lowercased()) { [weak self] global in
            switch global {
            case .failure(let error):
                print(error)
            case .success(let group):
                self?.globalGroupList = group
                self?.filteredGroup = group.filter({ (global: Group) -> Bool in
                    return name.isEmpty ? true : global.name.lowercased().contains(name.lowercased())
                })
            }
            self?.view?.updateView()
        }
    }
    
    private func getGlobalGroup() {
        vkApi.getGroupsSearch(token: Session.shared.token, name: "a") { [weak self] global in
            switch global {
            case .failure(let error):
                print(error)
            case .success(let group):
                self?.globalGroupList = Array(group).sorted { (one, two) in
                    one.name < two.name
                }
                self?.filteredGroup = self?.globalGroupList ?? []
            }
            self?.view?.updateView()
        }
        
    }
    
}

extension GlobalGroupsPresenterImplementation {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return globalGroupList.count
    }
    
    func numberOfRowsInSectionSearch() -> Int {
        return filteredGroup.count
    }
    
    func modelAtIndex(indexPath: IndexPath) -> Group? {
        return globalGroupList[indexPath.row]
    }
    
    func modelAtIndexSearch(indexPath: IndexPath) -> Group? {
        return filteredGroup[indexPath.row]
    }
}

