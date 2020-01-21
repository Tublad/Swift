
import Foundation
import RealmSwift

class GroupRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var content = ""
    @objc dynamic var participant = ""
    @objc dynamic var imageGroup = ""
    
    let groups = List<Group>()
    
    func addGroup(id: Int, name: String, content: String, particiant: String, imageGroup: String) {
        let realm = try! Realm()
        let group = GroupRealm()
        group.id = id
        group.name = name
        group.content = content
        group.participant = participant
        group.imageGroup = imageGroup
        
        try! realm.write {
            realm.add(group)
        }
    }
    
    func getGroup(id: Int) -> GroupRealm? {
        let realm = try! Realm()
        return realm.objects(GroupRealm.self).filter("id == %@", id).first
    }
    
}
