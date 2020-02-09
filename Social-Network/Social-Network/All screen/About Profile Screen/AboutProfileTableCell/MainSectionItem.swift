
import UIKit

class MainSectionItem {
    static func getShortListItem() -> [SectionItem] {
        let listItem = [
            SectionItem(name: "Друзья", imageItem: UIImage(systemName: "person.fill")!),
            SectionItem(name: "Сообщества", imageItem: UIImage(systemName: "person.2.fill")!),
            SectionItem(name: "Фотографии", imageItem: UIImage(systemName: "camera")!),
            SectionItem(name: "Новостная лента", imageItem: UIImage(systemName: "doc.plaintext")!)
        ]
        return listItem
    }
}
