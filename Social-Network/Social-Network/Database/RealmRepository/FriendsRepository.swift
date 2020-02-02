
import RealmSwift

protocol FriendSource {
    func getAll() throws -> Results<FriendRealm>
    func addFriends(friends: [Friend])
    func addFriend(friend: Friend)
    func getFriend(id: Int) -> FriendRealm?
    func deleteFriend(id: Int)
}

class FriendsRepository: FriendSource {
   
    func getAll() throws -> Results<FriendRealm> {
        do {
            let realm = try Realm()
            return realm.objects(FriendRealm.self)
        } catch {
            throw(error)
        }
    }
    
    func addFriends(friends: [Friend]) {
        do {
            let realm = try Realm()
            try realm.write {
                var friendRealmToAdd = [FriendRealm]()
                friends.forEach { friend in
                    let friendRealm = FriendRealm()
                    friendRealm.id = friend.id
                    friendRealm.firstName = friend.firstName
                    friendRealm.lastName = friend.lastName
                    friendRealm.avatar = friend.avatar
                    friendRealm.online = friend.online
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
    
    func getFriend(id: Int) -> FriendRealm? {
        let realm = try! Realm()
        return realm.objects(FriendRealm.self).filter("id == %@", id).first
    }
    
    func deleteFriend(id: Int) {
        do {
            let realm = try Realm()
            guard let friend = getFriend(id: id) else { return }
            realm.delete(friend)
        } catch {
            print(error)
        }
    }
}
