
import Foundation
import Alamofire

enum RequestError: Error {
    case failedError(message: String)
    case decodebleError
}

class VKApi {
    
    let vkURL = "https://api.vk.com/method/"
    
    func requestServer<T: Decodable>(requestURL: String,
                                     params: Parameters,
                                     completion: @escaping (Swift.Result<T, Error>) -> Void) {
        
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: params).responseData { (response) in
                            
                            switch response.result {
                            case .failure(let error):
                                completion(.failure(RequestError.failedError(message: error.localizedDescription)))
                            case .success(let data):
                                do {
                                    let responses = try JSONDecoder().decode(T.self, from: data)
                                    completion(.success(responses))
                                } catch let error {
                                    completion(.failure(RequestError.decodebleError))
                                }
                            }
        }
        
    }
    
    
    // запрос на список друзей данного пользователя
    func getFriendList(token: String,
                       completion: @escaping (Swift.Result<[Friends], Error>) -> Void) {
        
        let requestURL = vkURL + "friends.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "order": "name",
                      "v": "5.103",
                      "fields": "city,domain"]
        
        requestServer(requestURL: requestURL, params: params) { (friends: (Swift.Result<ResponseFriend, Error>)) in
            switch friends {
            case .failure(let error):
                completion(.failure(error))
            case.success(let friend):
                completion(.success(friend.response.items))
            }
        }
    }
    // запрос на список фотографий данного пользователя
    func getPhotos(token: String,
                   userId: String,
                   completion: @escaping (Swift.Result<[Photo], Error>) -> Void) {
        
        let requestURL = vkURL + "photos.get"
        let params = ["user_id": userId,
                      "access_token": token,
                      "album_id": "profile",
                      "extended": "1",
                      "rev": "1",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, params: params) { (photos: (Swift.Result<ResponsePhoto, Error>)) in
            switch photos {
            case .failure(let error):
                completion(.failure(error))
            case.success(let photo):
                completion(.success(photo.response.items))
            }
        }
        
    }
    
    // запрос на список групп данного пользователя
    func getGroups(token: String,
                   completion: @escaping (Swift.Result<[Group], Error>) -> Void) {
        
        let requestURL = vkURL + "groups.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "extended": "1",
                      "fields": "activity,members_count",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, params: params) { (groups: (Swift.Result<ResponseGroup, Error>)) in
            switch groups {
            case .failure(let error):
                completion(.failure(error))
            case.success(let group):
                completion(.success(group.response.items))
            }
        }
    }
    
    // запрос на поисковой запрос групп данного пользователя
    func getGroupsSearch(token: String, name: String,completion: @escaping (Swift.Result<[Group], Error>) -> Void){
        let requestURL = vkURL + "groups.search"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "q": name,
                      "count": "100",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, params: params) { (groups: (Swift.Result<ResponseGroup, Error>)) in
            switch groups {
            case .failure(let error):
                completion(.failure(error))
            case.success(let group):
                completion(.success(group.response.items))
            }
        }
        
    }
    
}
