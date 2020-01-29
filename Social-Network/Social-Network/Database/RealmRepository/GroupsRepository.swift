import RealmSwift

class GroupsRepository {
    
    func getAll() throws -> Results<GroupRealm> {
        do {
            let realm = try Realm()
            return realm.objects(GroupRealm.self)
        } catch {
            throw(error)
        }
    }
    
    func addGroups(groups: [Group]) {
        do {
            let realm = try Realm()
            try realm.write {
                var groupRealmToAdd = [GroupRealm]()
                groups.forEach { group in
                    let groupRealm = GroupRealm()
                    groupRealm.id = group.id
                    groupRealm.name = group.name
                    groupRealm.content = group.content
                    groupRealm.participant = group.participant
                    groupRealm.imageGroup = group.imageGroup
                    groupRealmToAdd.append(groupRealm)
                }
                realm.add(groupRealmToAdd, update: .modified)
            }
            print(realm.objects(GroupRealm.self))
        } catch {
            print(error)
        }
        
    }
    
    func addGroup(group: Group) {
        do {
            let realm = try Realm()
            try realm.write {
                let groupRealm = GroupRealm()
                groupRealm.id = group.id
                groupRealm.name = group.name
                groupRealm.content = group.content
                groupRealm.participant = group.participant
                groupRealm.imageGroup = group.imageGroup
                realm.add(groupRealm)
            }
        } catch {
            print(error)
        }
    }
}
