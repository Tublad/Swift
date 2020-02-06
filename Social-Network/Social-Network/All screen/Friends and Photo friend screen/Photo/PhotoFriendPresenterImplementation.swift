
import UIKit
import RealmSwift

protocol PhotoFriendPresenter {
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func modelAtIndex(indexPath: IndexPath) -> PhotoRealm?
    func getUrlArray() -> [URL]
}

class PhotoFriendPresenterImplementation: PhotoFriendPresenter {
    
    var user: FriendRealm?
    private var vkApi = VKApi()
    private var database: PhotoSource
    private var photoArray: Results<PhotoRealm>!
    private var configurator: PhotoConfiguration?
    
    private weak var view: UpdateView?
    
    func viewDidLoad() {
        getPhotoFromDatabase()
        getPhotoFromApi()
    }
    
    init(database: PhotoSource, view: UpdateView, user: FriendRealm?) {
        self.database = database
        self.view = view
        self.user = user
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

extension PhotoFriendPresenterImplementation {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return photoArray.count
        
    }
    
    func modelAtIndex(indexPath: IndexPath) -> PhotoRealm? {
        return photoArray[indexPath.row]
    }
    
    func getUrlArray() -> [URL] {
        return photoArray.map { URL(string: $0.url)! }
    }
    
}




