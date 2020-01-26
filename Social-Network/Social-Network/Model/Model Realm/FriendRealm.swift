
import Foundation
import RealmSwift

class FriendRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var online = 0
    @objc dynamic var avatar = ""
    @objc dynamic var cityName = ""
    
    let friends = List<Friends>()
    
    func addFriend(id: Int, firstName: String, lastName: String, online: Int, avatar: String, cityName: String) {
        let realm = try! Realm()
        let friend = FriendRealm()
        friend.id = id
        friend.firstName = firstName
        friend.lastName = lastName
        friend.online = online
        friend.avatar = avatar
        friend.cityName = cityName
        
        try! realm.write {
            realm.add(friend)
        }
    }
    
    func getFriend(id: Int) -> FriendRealm? {
        let realm = try! Realm()
        return realm.objects(FriendRealm.self).filter("id == %@", id).first
    }
}
