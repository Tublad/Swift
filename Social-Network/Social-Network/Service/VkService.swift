
import Foundation
import Alamofire

class VKApi {
    
    let vkURL = "https://api.vk.com/method/"
    // запрос на список друзей данного пользователя
    func getFriendList(token: String, completion: @escaping ([Friends]) -> Void) {
        let requestURL = vkURL + "friends.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "order": "name",
                      "v": "5.103",
                      "fields": "city,domain"]
        
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: params).responseData { (response) in
                            guard let data = response.value else { return }
                            do {
                                let responses = try JSONDecoder().decode(ResponseFriend.self, from: data).response.items
                                
                                completion(responses)
                            } catch {
                                print(error)
                            }
        }
    }
    // запрос на список фотографий данного пользователя
    func getPhotos(token: String, userId: String, completion: @escaping ([Photo]) -> Void) {
        let requestURL = vkURL + "photos.get"
        let params = ["user_id": userId,
                      "access_token": token,
                      "album_id": "profile",
                      "extended": "1",
                      "rev": "1",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: params).responseData { (response) in
                            guard let data = response.value else { return }
                            do {
                                let responses = try JSONDecoder().decode(ResponsePhoto.self, from: data).response.items
                                completion(responses)
                            } catch {
                                print(error)
                            }
        }
    }
    
    // запрос на список групп данного пользователя
    func getGroups(token: String, completion: @escaping ([Group]) -> Void) {
        let requestURL = vkURL + "groups.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "extended": "1",
                      "fields": "activity,members_count",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: params).responseData { (response) in
                            guard let data = response.value else { return }
                            do {
                                let responses = try JSONDecoder().decode(ResponseGroup.self, from: data).response.items
                                completion(responses)
                            } catch {
                                print(error)
                            }
        }

    }
    // запрос на поисковой запрос групп данного пользователя
    func getGroupsSearch(token: String, name: String, completion: @escaping ([Group]) -> Void) {
        let requestURL = vkURL + "groups.search"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "q": name,
                      "count": "100",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .get,
                          parameters: params).responseData { (response) in
                        guard let data = response.value else { return }
                        do {
                            let responses = try JSONDecoder().decode(ResponseGroup.self, from: data).response.items
                           completion(responses)
                        } catch {
                            print(error)
                        }
        }
    }
    
}
