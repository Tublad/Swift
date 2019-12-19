

import UIKit

struct Section<T> {
    var title: String
    var item: [T]
}


class FriendTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendList =
        [Friends(firstName: "Антон", lastName: "Ермов", imageFriend: "image2", isOnline: false, message: Message(textUser: "Давай, доброй ночи!", time: "23:30")),
         Friends(firstName: "Егор", lastName: "Масляннов", imageFriend: "image1", isOnline: true, message:  Message(textUser: "Пока", time: "15:14")),
         Friends(firstName: "Марк", lastName: "Шварцкопф", imageFriend: "image3", isOnline: false, message: Message(textUser: "Привет, как дела?", time: "13:11")),
         Friends(firstName: "Марина", lastName: "Усува", imageFriend: "image4", isOnline: true, message: Message(textUser: "Ххахаха, нормас", time: "16:04")),
         Friends(firstName: "Яна", lastName: "Ярёмина", imageFriend: "image1", isOnline: false, message: Message(textUser: "Чем занимаешься?", time: "14:31")),
         Friends(firstName: "Максим", lastName: "Уваров", imageFriend: "image2", isOnline: true, message: Message(textUser: "Может в кино?", time: "16:30")),
         Friends(firstName: "Ян", lastName: "У", imageFriend: "image4", isOnline: false, message: Message(textUser: "Ты чего молчишь?", time: "Вчера")),
         Friends(firstName: "Иван", lastName: "Григоров", imageFriend: "image3", isOnline: true, message:  Message(textUser: "Кстати, ты прав, думаю надо что нибудь придумать по этому поводу!", time: "18:03")),
         Friends(firstName: "Варвара", lastName: "Мирова", imageFriend: "image1", isOnline: true, message: Message(textUser: "Привет", time: "Сейчас")),
         Friends(firstName: "Ринат", lastName: "Аринат", imageFriend: "image4", isOnline: false, message: Message(textUser: "Давай, удачи!", time: "Сейчас")),
         Friends(firstName: "Кирилл", lastName: "Ягодка", imageFriend: "image3", isOnline: false, message: Message(textUser: "Хмммммм", time: "Вчера")),
         Friends(firstName: "Арам", lastName: "Мартирасян", imageFriend: "image2", isOnline: true, message: Message(textUser: "Ну не знаю", time: "16:03")),
         Friends(firstName: "Гагик", lastName: "Мартирасян", imageFriend: "image1", isOnline: false, message: Message(textUser: "Давай познакомимся", time: "Сейчас")),
         Friends(firstName: "Александр", lastName: "Шварцкопф", imageFriend: "image1", isOnline: true, message: Message(textUser: "Дарова братишка", time: "Сейчас")),
         Friends(firstName: "Никита", lastName: "Гусельников", imageFriend: "image4", isOnline: false, message: Message(textUser: "Сегодня туса будет! Давай подтягивайся =) Тебя только не хватает!! Подьезжай на улицу Красный путь 127 кв 60 ;) ", time: "Вчера")),
         Friends(firstName: "Никита", lastName: "Попов", imageFriend: "image3", isOnline: true, message:  Message(textUser: "Пока", time: "Вчера"))]
    
    var friendSection = [Section<Friends>]()
    
    override func viewDidLoad() {
        searchBar.delegate = self
        madeOfSortedSection()
    }
    
    func madeOfSortedSection() {
        let friendDictionary = Dictionary(grouping: friendList) {
            $0.lastName.prefix(1)
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
            cell.animationImage()
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
        view.tintColor = UIColor.clear
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action, index) in
            self.friendList.removeAll {
                $0.firstName == self.friendSection[indexPath.section].item[indexPath.row].firstName
            }
            self.madeOfSortedSection()
            self.tableView.reloadData()
        }
        return [deleteAction]
    }
}

extension FriendTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendDictionary = Dictionary(grouping: friendList.filter({ (friend) -> Bool in
            return searchText.isEmpty ? true : friend.firstName.lowercased().contains(searchText.lowercased()) || friend.lastName.lowercased().contains(searchText.lowercased())
        })) {
            $0.lastName.prefix(1)
        }
        friendSection = friendDictionary.map { Section(title: String($0.key), item: $0.value) }
        friendSection.sort { $0.title < $1.title }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}
