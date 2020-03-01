
import Foundation

protocol PhotoConfiguration {
    func configure(view: PhotoFriendCollectionViewController, user: FriendRealm?)
}

class PhotoConfigurationImplementation: PhotoConfiguration {
    func configure(view: PhotoFriendCollectionViewController, user: FriendRealm?) {
        view.presenter = PhotoFriendPresenterImplementation(database: PhotosRepository(), view: view, user: user)
    }
    
    
}
