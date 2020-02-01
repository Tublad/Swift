
/*import UIKit
import RealmSwift

protocol ProfileFriendPresenter {
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func modelAtIndex(indexPath: IndexPath) -> PhotoRealm?
}

class ProfileFriendPresenterImplementation: ProfileFriendPresenter {

    private var vkApi = VKApi()
    private var database = PhotosRepository()
    var user: FriendRealm?
    
    private var photoArray: Results<PhotoRealm>!
    
    func viewDidLoad() {
        getPhotoFromDatabase()
        getPhotoFromApi()
    }
 
    //MARK: попробывать добавить фотографии через id 
 
    private func getPhotoFromDatabase(_ id: Int) {
        do {
             photoArray = try database.getAll().filter { user in
                user.id == id
            }
            
            
        } catch {
            print(error)
        }
    }
 
    private func getPhotoFromApi() {
        vkApi.getPhotos(token: Session.shared.token, userId: String(id)) { [weak self] photo in
            switch photo {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self?.photoArray = photos
                self?.database.addPhotos(photos: photos)
                self?.collectionView.reloadData()
            }
        }
        
    }
    
}

extension ProfileFriendPresenterImplementation {
    
    func numberOfSections() -> Int {
        
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        
    }
    
    func modelAtIndex(indexPath: IndexPath) -> PhotoRealm? {
        
    }
    
    
}


*/
