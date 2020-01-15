
import Foundation
import Alamofire

class VKApi {
    
    let vkURL = "https://api.vk.com/method/"
    // запрос на список друзей данного пользователя
    func getFriendList(token: String) {
        let requestURL = vkURL + "friends.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "order": "name",
                      "v": "5.103",
                      "fields": "city,domain"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON { (response) in
                            print(response.value)
        }
    }
    // запрос на список фотографий данного пользователя
    func getPhotos(token: String) {
        let requestURL = vkURL + "photos.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "album_id": "profile",
                      "rev": "0",
                      "extended": "1",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON { (response) in
                            print(response.value)
        }
    }
    // запрос на список групп данного пользователя
    func getGroups(token: String) {
        let requestURL = vkURL + "groups.get"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "extended": "1",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON { (response) in
                            print(response.value)
        }
    }
    // запрос на поисковой запрос групп данного пользователя
    // сделал пока Music, пока не знаю как по другому
    func getGroupsSearch(token: String, name: String) {
        let requestURL = vkURL + "groups.search"
        let params = ["user_id": "70406229",
                      "access_token": token,
                      "q": name,
                      "count": "100",
                      "v": "5.103"]
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params).responseJSON { (response) in
                            print(response.value)
        }
    }
    
}
