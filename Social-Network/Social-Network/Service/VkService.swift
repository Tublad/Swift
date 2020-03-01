
import Foundation
import Alamofire

enum RequestError: Error {
    case failedError(message: String)
    case decodebleError
}

class VKApi {
    
    let vkURL = "https://api.vk.com/method/"
    
    typealias Out = Swift.Result
    
    //MARK: общий шаблон на запрос данных от серсвера VKApi
    
    func requestServer<T: Decodable>(requestURL: String,
                                     method: HTTPMethod = .get,
                                     params: Parameters,
                                     completion: @escaping (Out<[T], Error>) -> Void) {
        
        Alamofire.request(requestURL,
                          method: method,
                          parameters: params).responseData { (response) in
                            
                            switch response.result {
                            case .failure(let error):
                                completion(.failure(RequestError.failedError(message: error.localizedDescription)))
                            case .success(let data):
                                do {
                                    let responses = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                                    completion(.success(responses.response.items))
                                } catch let error {
                                    completion(.failure(error))
                                }
                            }
        }
        
    }
    
    
    //MARK: запрос на список друзей данного пользователя
    
    func getFriendList(token: String,
                       completion: @escaping (Out<[Friend], Error>) -> Void) {
        
        let requestURL = vkURL + "friends.get"
        let params = ["access_token": token,
                      "order": "name",
                      "v": "5.103",
                      "fields": "city,domain,photo_100"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) { completion($0) }

    }
    
    //MARK: запрос на список фотографий данного пользователя
    
    func getPhotos(token: String,
                   userId: String,
                   completion: @escaping (Out<[Photo], Error>) -> Void) {
        
        let requestURL = vkURL + "photos.get"
        let params = ["user_id": userId,
                      "access_token": token,
                      "album_id": "profile",
                      "extended": "1",
                      "rev": "1",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) { completion($0) }
        
    }
    
    //MARK: запрос на список групп данного пользователя
    
    func getGroups(token: String,
                   completion: @escaping (Out<[Group], Error>) -> Void) {
        
        let requestURL = vkURL + "groups.get"
        let params = ["access_token": token,
                      "extended": "1",
                      "fields": "activity,members_count",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) { completion($0) }
    }
    
    //MARK: запрос на поисковой запрос групп данного пользователя
    
    func getGroupsSearch(token: String, name: String,
                         completion: @escaping (Out<[Group], Error>) -> Void){
        let requestURL = vkURL + "groups.search"
        let params = ["access_token": token,
                      "q": name,
                      "count": "100",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) { completion($0) }
    }
    
    func getProfile(token: String,
                    completion: @escaping (Out<[Profile], Error>) -> Void){
        let requestURL = vkURL + "users.get"
        let params = ["access_token" : token,
                      "fields": "photo_200,city,counters,bdate",
                      "name_case": "Nom",
                      "v": "5.103"]
 
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: params).responseData { (response) in
                            
                            switch response.result {
                            case .failure(let error):
                                completion(.failure(RequestError.failedError(message: error.localizedDescription)))
                            case .success(let data):
                                do {
                                    let responses = try JSONDecoder().decode(ProfileResponse.self, from: data)
                                    completion(.success(responses.response))
                                } catch let error {
                                    completion(.failure(error))
                                }
                            }
        }
    }
}

