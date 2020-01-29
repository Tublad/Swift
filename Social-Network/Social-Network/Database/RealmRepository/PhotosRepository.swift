import RealmSwift

class PhotosRepository {
    
    func getAll() throws -> Results<PhotoRealm> {
        do {
            let realm = try Realm()
            return realm.objects(PhotoRealm.self)
        } catch {
            throw(error)
        }
    }
    
    func addPhotos(photos: [Photo]) {
        do {
            let realm = try Realm()
            try realm.write {
                var photoRealmToAdd = [PhotoRealm]()
                photos.forEach { photo in
                    let photoRealm = PhotoRealm()
                    photoRealm.id = photo.id
                    photoRealm.userId = photo.userId
                    photoRealm.url = photo.url
                    photoRealm.userLike = photo.userLike
                    photoRealm.like = photo.like
                    photoRealm.repost = photo.repost
                    photoRealm.comment = photo.comment
                    photoRealmToAdd.append(photoRealm)
                }
                realm.add(photoRealmToAdd, update: .modified)
            }
            print(realm.objects(PhotoRealm.self))
        } catch {
            print(error)
        }
        
    }
    
    func addPhoto(photo: Photo) {
        do {
            let realm = try Realm()
            try realm.write {
                let photoRealm = PhotoRealm()
                photoRealm.id = photo.id
                photoRealm.userId = photo.userId
                photoRealm.url = photo.url
                photoRealm.userLike = photo.userLike
                photoRealm.like = photo.like
                photoRealm.repost = photo.repost
                photoRealm.comment = photo.comment
                realm.add(photoRealm)
            }
        } catch {
            print(error)
        }
    }
}
