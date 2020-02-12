
import RealmSwift

protocol ProfileSource {
    func getProfile() throws -> Results<ProfileRealm>
    func addProfile(profiles: [Profile])
}

class ProfileRepository: ProfileSource {

    func getProfile() throws -> Results<ProfileRealm> {
        do {
            let realm = try Realm()
            return realm.objects(ProfileRealm.self)
        } catch {
            throw (error)
        }
    }
    
    func addProfile(profiles: [Profile]) {
        do {
            let realm = try Realm()
            try realm.write {
                var profileRealmToAdd = [ProfileRealm]()
                profiles.forEach { profile in
                    let profileRealm = ProfileRealm()
                    profileRealm.id = profile.id
                    profileRealm.firstName = profile.firstName
                    profileRealm.lastName = profile.lastName
                    profileRealm.avatar = profile.avatar
                    profileRealm.age = profile.age
                    profileRealm.canClosed = profile.canClosed
                    profileRealm.isClosed = profile.isClosed
                    profileRealm.cityName = profile.cityName
                    profileRealm.albums = profile.albums
                    profileRealm.videos = profile.videos
                    profileRealm.audios = profile.audios
                    profileRealm.photos = profile.photos
                    profileRealm.groups = profile.groups
                    profileRealm.friends = profile.friends
                    profileRealm.gifts = profile.gifts
                    profileRealm.followers = profile.followers
                    profileRealmToAdd.append(profileRealm)
                }
                realm.add(profileRealmToAdd, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
