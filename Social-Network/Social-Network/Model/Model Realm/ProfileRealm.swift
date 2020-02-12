
import RealmSwift
import Foundation

class ProfileRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var age = ""
    @objc dynamic var avatar = ""
    @objc dynamic var isClosed = false
    @objc dynamic var canClosed = false
    @objc dynamic var cityName = ""
    
    @objc dynamic var albums = 0
    @objc dynamic var videos = 0
    @objc dynamic var audios = 0
    @objc dynamic var photos = 0
    @objc dynamic var groups = 0
    @objc dynamic var gifts = 0
    @objc dynamic var friends = 0
    @objc dynamic var followers = 0
    
    let profile = List<Profile>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> Profile {
        let profile = Profile()
        profile.id = id
        profile.firstName = firstName
        profile.lastName = lastName
        profile.age = age
        profile.isClosed = isClosed
        profile.canClosed = canClosed
        profile.cityName = cityName
        profile.albums = albums
        profile.videos = videos
        profile.audios = audios
        profile.photos = photos
        profile.groups = groups
        profile.gifts = gifts
        profile.friends = friends
        profile.followers = followers
        profile.avatar = avatar
        return profile
    }
}

