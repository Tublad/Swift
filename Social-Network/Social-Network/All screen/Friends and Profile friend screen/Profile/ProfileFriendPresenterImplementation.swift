
import UIKit
import RealmSwift

protocol ProfileFriendPresenter {
    var user: FriendRealm? { get set}
    
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func modelAtIndex(indexPath: IndexPath) -> PhotoRealm?
    func getPhotoArray() -> Results<PhotoRealm>
}

class ProfileFriendPresenterImplementation: ProfileFriendPresenter {

    var user: FriendRealm?
    
    private var vkApi = VKApi()
    private var database = PhotosRepository()
    private var photoArray: Results<PhotoRealm>!
    private var configurator: ProfileConfiguration?
    
    private weak var view: ProfileViewUpdate?
    
    func viewDidLoad() {
        getPhotoFromDatabase()
        getPhotoFromApi()
    }
    
    init(database:PhotosRepository, view: ProfileViewUpdate) {
        self.database = database
        self.view = view
    }
 
    //MARK: попробывать добавить фотографии через id 
 
    private func getPhotoFromDatabase() {
        guard let id = user?.id else { return }
        do {
            photoArray = try database.getPhoto(userId: id)
        } catch {
            print(error)
        }
        view?.updateView()
    }
 
    private func getPhotoFromApi() {
        guard let id = user?.id else { return }
        vkApi.getPhotos(token: Session.shared.token, userId: String(id)) { [weak self] photo in
            switch photo {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self?.database.addPhotos(photos: photos)
                self?.getPhotoFromDatabase()
            }
        }
        
    }
    
}

extension ProfileFriendPresenterImplementation {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
       return photoArray.count

    }
    
    func modelAtIndex(indexPath: IndexPath) -> PhotoRealm? {
        return photoArray[indexPath.row]
    }
    
    func getPhotoArray() -> Results<PhotoRealm> {
        return photoArray
    }
}



