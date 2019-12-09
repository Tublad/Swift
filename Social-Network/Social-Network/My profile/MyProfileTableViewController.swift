 import UIKit
 
 class MyProfileTableViewController: UITableViewController {
    
    var myProfile = Profile(firstName: "Евгений", lastName: "Шварцкопф", age: "27", country: "Омск", education: "Среднее", status: "Учусь", photo: "myPhoto", isOnline: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onLikeAction(_ sender: Any) {
        guard let liked = sender as? LiKeButton else {
            return
        }
        liked.like()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? MyProfileTableViewCell else {
            return UITableViewCell()
            
        }
        cell.fullNameLabel.text = myProfile.firstName + " " + myProfile.lastName
        var isOnline: String
        if myProfile.isOnline == true {
            isOnline = "online"
        } else {
            isOnline = "25 минут назад был онлайн"
        }
        cell.isOnlineLabel.text = isOnline
        cell.isOnlineImage.image = UIImage(named: isOnline)
        cell.ageAndCity.text = myProfile.age + " лет, " + myProfile.country
        
        return cell
    }
    
 }
