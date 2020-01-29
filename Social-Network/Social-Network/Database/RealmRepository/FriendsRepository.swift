
import RealmSwift

class FriendsRepository {
    
    func getAll() throws -> Results<FriendRealm> {
        do {
            let realm = try Realm()
            return realm.objects(FriendRealm.self)
        } catch {
            throw(error)
        }
    }
    
    func addFriends(friend: [Friend]) {
        do {
            let realm = try Realm()
            try realm.write {
                var friendRealmToAdd = [FriendRealm]()
                friend.forEach { friends in
                    let friendRealm = FriendRealm()
                    friendRealm.id = friends.id
                    friendRealm.firstName = friends.firstName
                    friendRealm.lastName = friends.lastName
                    friendRealm.avatar = friends.avatar
                    friendRealm.online = friends.online
                    friendRealmToAdd.append(friendRealm)
                }
                realm.add(friendRealmToAdd, update: .modified)
            }
            print(realm.objects(FriendRealm.self))
        } catch {
            print(error)
        }
        
    }
    
    func addFriend(friend: Friend) {
        do {
            let realm = try Realm()
            try realm.write {
                let friendRealm = FriendRealm()
                friendRealm.id = friend.id
                friendRealm.firstName = friend.firstName
                friendRealm.lastName = friend.lastName
                friendRealm.avatar = friend.avatar
                friendRealm.online = friend.online
                realm.add(friendRealm)
            }
        } catch {
            print(error)
        }
    }
}
