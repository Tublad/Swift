
import Foundation
import RealmSwift

class GroupRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var content = ""
    @objc dynamic var participant = 0
    @objc dynamic var imageGroup = ""
    
    let groups = List<Group>()  // если за комментить то все уходит и ничего не показывает 
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> Group {
        let group = Group()
        group.id = id
        group.name = name
        group.content = content
        group.participant = participant
        group.imageGroup = imageGroup
        return group
    }
    
}

