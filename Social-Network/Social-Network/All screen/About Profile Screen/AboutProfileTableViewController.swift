
import UIKit
import Foundation

enum CellTypes {
    case profile
    case mainSection(item: SectionItem)
    case vkPay
}

class AboutProfileTableViewController: UITableViewController {
    
    var shortSection: [CellTypes] = [] // Массив для 2-ой секции и в тоже время Массив для всех разделов
    var models: [[CellTypes]] = [] // Массив Массивов с контентом всей страницы
    var titleHeader = [String]()
    
    // это убирает Header (большая высота поумолчанию)
    /*
     override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     return nil
     }*/
    
    override func viewDidLoad() {
        addContent()
        newCellRegister()
        countSection()
        settingFooter()
    }
    
    func settingFooter() {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footerView
    }
    
    func countSection() {
        for _ in models{
            titleHeader.append(" ")
        }
    }
    
    
    func addContent() {
        // Добавил короткий и в тоже время полный список ( временно )
        shortSection.append(contentsOf: MainSectionItem.getShortListItem().map{
            CellTypes.mainSection(item: $0)
        })
        models.append([.profile])
        models.append(shortSection)
        models.append([.vkPay])
    }
    
    func newCellRegister() {
        tableView.register(UINib(nibName: "ProfileTableCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        tableView.register(UINib(nibName: "MainSectionTableCell", bundle: nil), forCellReuseIdentifier: "MainSectionCell")
        tableView.register(UINib(nibName: "VKPayTableCell", bundle: nil), forCellReuseIdentifier: "VKPayCell")
    }
    
    @IBAction func goSettingUserButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingView = storyboard.instantiateViewController(identifier: "SettingTableViewController") as! SettingTableViewController
        self.navigationController?.pushViewController(settingView, animated: true)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        settingView.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: DataSource

extension AboutProfileTableViewController {
    // count Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    //count cell
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleHeader[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    
    // высота ячеек
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
        case .profile: return 72
        case .mainSection: return 45
        case .vkPay: return 45
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
            
        // first Profile Cell
        case .profile:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileTableCell else {
                return UITableViewCell()
            }
            cell.profileImage.image = UIImage(named: "MyPhoto")
            cell.fullName.text = "Женя Шварцкопф"
            cell.profileAccount.text = "Открытый профиль"
            return cell
            
        // second Main Section (на другие контроллеры)
        case let .mainSection(item: section):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSectionCell") as? MainSectionTableCell else {
                return UITableViewCell()
            }
            
            cell.fullNameLabel.text = section.name
            cell.sectionImage.image = section.imageItem
            cell.goToView.imageView?.image = UIImage(systemName: "chevron.right")
            return cell
            
        // third VKPay Cell
        case .vkPay:
            let vkPay = tableView.dequeueReusableCell(withIdentifier: "VKPayCell") as? VKPayTableCell
            return vkPay ?? UITableViewCell()
        }
    }
}

//MARK: Delegate
extension AboutProfileTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
        case .profile:
            print("Action profile view go")
        case let .mainSection(item: SectionItem):
            let name = SectionItem.name
            
            switch name {
            case "Друзья":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let friendViewController = storyboard.instantiateViewController(identifier: "FriendTableViewController") as! FriendTableViewController
                friendViewController.configurator = FriendConfiguratorImplementation()
                self.navigationController?.pushViewController(friendViewController, animated: true)
                let backButton = UIBarButtonItem()
                backButton.title = ""
                backButton.tintColor = .white
                friendViewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            case "Сообщества":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let groupViewController = storyboard.instantiateViewController(identifier: "GroupTableViewController") as! GroupTableViewController
                groupViewController.configurator = GroupConfiguratorImplementation()
                self.navigationController?.pushViewController(groupViewController, animated: true)
                let backButton = UIBarButtonItem()
                backButton.title = ""
                backButton.tintColor = .white
                groupViewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            case "Фотографии":
                print("Show me please, my photo")
            case "Новостная лента":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newsViewController = storyboard.instantiateViewController(identifier: "NewsViewController") as! NewsViewController
                self.navigationController?.pushViewController(newsViewController, animated: true)
                let backButton = UIBarButtonItem()
                backButton.title = ""
                backButton.tintColor = .white
                newsViewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            default:
                print("OOOooopsss... it's going wrong! Fix me")
            }
        case .vkPay:
            print("Show me price list in VK Server")
        }
    }
}
