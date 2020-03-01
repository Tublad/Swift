
import UIKit

class SettingSectionItem {
    
    static func getNotificationListItem() -> [SectionItem] {
        let listItem = [
            SectionItem(name: "Уведомления", imageItem: UIImage(systemName: "bell.fill")!),
            SectionItem(name: "Не беспокоить", imageItem: UIImage(systemName: "nosign")!)
        ]
        return listItem
    }
    
    static func getMainSettingListItem() -> [SectionItem] {
        let listItem = [
            SectionItem(name: "Аккаунт", imageItem: UIImage(systemName: "person.fill")!),
            SectionItem(name: "Внешний вид", imageItem: UIImage(systemName: "paintbrush.fill")!),
            SectionItem(name: "Основные", imageItem: UIImage(systemName: "gear")!),
            SectionItem(name: "Приватность", imageItem: UIImage(systemName: "hand.raised.fill")!),
            SectionItem(name: "Черный Список", imageItem: UIImage(systemName: "person.2.fill")!)
        ]
        return listItem
    }
    
    static func getBalanceListItem() -> [SectionItem] {
        let listItem = [
            SectionItem(name: "Баланс", imageItem: UIImage(systemName: "creditcard.fill")!),
            SectionItem(name: "Подписка на музыку", imageItem: UIImage(systemName: "music.note")!)
        ]
        return listItem
    }
    
}
