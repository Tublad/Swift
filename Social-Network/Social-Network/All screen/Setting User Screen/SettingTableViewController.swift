
import UIKit

enum SettingCell {
    case notification(item: SectionItem)
    case mainSetting(item: SectionItem)
    case balance(item: SectionItem)
    case aboutApp
    case quit
}

class SettingTableViewController: UITableViewController {
    
    var notificationSection: [SettingCell] = [] //
    var mainSettingSection: [SettingCell] = [] //
    var balanceSection: [SettingCell] = [] //
    var models: [[SettingCell]] = []
    var titleHeader = [String]()
    
    override func viewDidLoad() {
        addContent()
        countSection()
        newCellRegister()
        settingFooter()
    }
    
    private func countSection() {
        for _ in models {
            titleHeader.append(" ")
        }
    }
    
    func settingFooter() {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footerView
    }
    
    private func addContent() {
        
        notificationSection.append(contentsOf: SettingSectionItem.getNotificationListItem().map {
            SettingCell.notification(item: $0)
        })
        
        mainSettingSection.append(contentsOf: SettingSectionItem.getMainSettingListItem().map {
            SettingCell.mainSetting(item: $0)
        })
        
        balanceSection.append(contentsOf: SettingSectionItem.getBalanceListItem().map {
            SettingCell.balance(item: $0)
        })
        models.append(notificationSection)
        models.append(mainSettingSection)
        models.append(balanceSection)
        models.append([.aboutApp])
        models.append([.quit])
        
    }
    
    private func newCellRegister() {
        tableView.register(UINib(nibName: "MainSectionTableCell", bundle: nil),
                           forCellReuseIdentifier: "MainSectionCell")
        tableView.register(UINib(nibName: "QuitTableCell", bundle: nil),
                           forCellReuseIdentifier: "QuitCell")
    }
}

// MARK: DataSource

extension SettingTableViewController {
    
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
        view.tintColor = UIColor.black
    }
    
    // высота ячеек
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
        case .notification: return 45
        case .mainSetting: return 45
        case .balance: return 45
        case .aboutApp: return 45
        case .quit: return 45
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = models[indexPath.section][indexPath.row]
        
        switch row {
            
        // Первая ячейка для отображения уведомления
        case let .notification(item: section):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSectionCell") as? MainSectionTableCell else {
                return UITableViewCell()
            }
            
            cell.fullNameLabel.text = section.name
            cell.sectionImage.image = section.imageItem
            cell.goToView.imageView?.image = UIImage(systemName: "chevron.right")
            return cell
            
        // Вторая ячейка для отображение основных настроек пользователя
        case let .mainSetting(item: section):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSectionCell") as? MainSectionTableCell else {
                return UITableViewCell()
            }
            
            cell.fullNameLabel.text = section.name
            cell.sectionImage.image = section.imageItem
            cell.goToView.imageView?.image = UIImage(systemName: "chevron.right")
            return cell
            
        // Третья ячейка для отображение баланса пользователя в приложение и дальнешиие покупки
        case let .balance(item: section):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSectionCell") as? MainSectionTableCell else {
                return UITableViewCell()
            }
            
            cell.fullNameLabel.text = section.name
            cell.sectionImage.image = section.imageItem
            cell.goToView.imageView?.image = UIImage(systemName: "chevron.right")
            return cell
            
        // Четвертая ячейка для отображение информации о приложении
        case .aboutApp:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSectionCell") as? MainSectionTableCell else {
                return UITableViewCell()
            }
            
            cell.fullNameLabel.text = "О приложении"
            cell.sectionImage.image = UIImage(systemName: "exclamationmark.circle.fill")
            cell.goToView.imageView?.image = UIImage(systemName: "chevron.right")
            return cell
            
        // Пятая последняя ячейка и закочительная для завершения сеанса пользователя в приложении
        case .quit:
            let quit = tableView.dequeueReusableCell(withIdentifier: "QuitCell") as? QuitTableCell
            return quit ?? UITableViewCell()
        }
    }
}
