
import Foundation

//MARK: Шаблоны для построения запроса

class CommonResponse<T: Decodable>: Decodable {
    var response: CommonResponseArray<T>
}

class CommonResponseArray<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
}
