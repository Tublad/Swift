

import UIKit

struct Section<T> {
    var title: String
    var item: [T]
}


class FriendTableViewController: UITableViewController {
    
    var friendList =
        [Friends(firstName: "Антон", lastName: "Ермов", imageFriend: "image2", isOnline: false),
         Friends(firstName: "Егор", lastName: "Масляннов", imageFriend: "image1", isOnline: true),
         Friends(firstName: "Марк", lastName: "Шварцкопф", imageFriend: "image3", isOnline: false),
         Friends(firstName: "Марина", lastName: "Усува", imageFriend: "image4", isOnline: true),
         Friends(firstName: "Яна", lastName: "Ярёмина", imageFriend: "image1", isOnline: false),
         Friends(firstName: "Максим", lastName: "Уваров", imageFriend: "image2", isOnline: true),
         Friends(firstName: "Ян", lastName: "У", imageFriend: "image4", isOnline: false),
         Friends(firstName: "Иван", lastName: "Григоров", imageFriend: "image3", isOnline: true),
         Friends(firstName: "Варвара", lastName: "Мирова", imageFriend: "image1", isOnline: true),
         Friends(firstName: "Ринат", lastName: "Аринат", imageFriend: "image4", isOnline: false),
         Friends(firstName: "Кирилл", lastName: "Ягодка", imageFriend: "image3", isOnline: false),
         Friends(firstName: "Арам", lastName: "Мартирасян", imageFriend: "image2", isOnline: true),
         Friends(firstName: "Гагик", lastName: "Мартирасян", imageFriend: "image1", isOnline: false),
         Friends(firstName: "Александр", lastName: "Шварцкопф", imageFriend: "image1", isOnline: true),
         Friends(firstName: "Никита", lastName: "Гусельников", imageFriend: "image4", isOnline: false),
         Friends(firstName: "Никита", lastName: "Попов", imageFriend: "image3", isOnline: true)]
    
    
    var friendSection = [Section<Friends>]()
    
    override func viewDidLoad() {
        let friendDictionary = Dictionary(grouping: friendList) {
            $0.firstName.prefix(1)
        }
        friendSection = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
        friendSection.sort { $0.title < $1.title }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendSection[section].item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        
        cell.nameFriend.text = friendSection[indexPath.section].item[indexPath.row].firstName + " " + friendSection[indexPath.section].item[indexPath.row].lastName
        cell.photoFriend.image = UIImage(named: friendSection[indexPath.section].item[indexPath.row].imageFriend)
        var image: String
        if friendSection[indexPath.section].item[indexPath.row].isOnline == true {
            image = "onlineFriend"
        } else {
            image = " "
        }
        
        cell.isOnline.image = UIImage(named: image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = friendList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let ProfileFriendCollectionView = storyboard.instantiateViewController(identifier: "ProfileFriendCollectionViewController") as? ProfileFriendCollectionViewController else {
            return 
        }
        
        ProfileFriendCollectionView.user = userName
        self.navigationController?.pushViewController(ProfileFriendCollectionView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section].title
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSection.map { $0.title  }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGray
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
}
