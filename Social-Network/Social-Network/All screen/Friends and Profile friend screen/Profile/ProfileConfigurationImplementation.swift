
import Foundation

protocol ProfileConfiguration {
    func configure(view: ProfileFriendCollectionViewController)
}

class ProfileConfigurationImplementation: ProfileConfiguration {
    func configure(view: ProfileFriendCollectionViewController) {
        view.presenter = ProfileFriendPresenterImplementation(database: PhotosRepository(), view: view)
    }
    
    
}
