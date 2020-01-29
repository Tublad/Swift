
import UIKit

enum CollectionSize {
    case one
    case two
    case three
    case four
}

class CustomCollectionViewLayout: UICollectionViewLayout {
    
    private var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    
    private var cellHeight: CGFloat = 0
    private var totalCellsHeight: CGFloat = 0
    private var twoColumns = 2
    private var threeColumns = 3
    private var fourColumns = 4
    
   
    override func prepare() {
        guard let collection = collectionView else { return }
        
        let itemCount = collection.numberOfItems(inSection: 0)
        let singleItemInRowWidth = collection.frame.width
        let twoItemsInRowWidth = collection.frame.width / CGFloat(twoColumns)
        let threeItemsInRowWidth = collection.frame.width / CGFloat(threeColumns)
        let fourItemsInRowWidth = collection.frame.width / CGFloat(fourColumns)
        
        totalCellsHeight = collection.frame.width
        
        let row = CGFloat(itemCount / fourColumns)
        let countItemsInLastRow = CGFloat(itemCount % fourColumns)
        
        if itemCount % 4 == 0 {
            cellHeight = totalCellsHeight / row
        } else {
            cellHeight = totalCellsHeight / (row + 1)
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for element in 0..<itemCount {
            let indexPath = IndexPath(item: element, section: 0)
            let attributeForIndex = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            var itemSize: CollectionSize
            if (element + 1) <= Int(row * 4) {
                itemSize = .four
            } else if countItemsInLastRow == 3 {
                itemSize = .three
            } else if countItemsInLastRow == 2 {
                itemSize = .two
            } else {
                itemSize = .one
            }
            
            switch itemSize {
            case .one:
                attributeForIndex.frame = CGRect(x: 0,
                                                 y: y,
                                                 width: singleItemInRowWidth,
                                                 height: cellHeight)
                y += cellHeight
            case .two:
                attributeForIndex.frame = CGRect(x: x,
                                                 y: y,
                                                 width: twoItemsInRowWidth,
                                                 height: cellHeight)
                if (element + 1) % (twoColumns + 1) == 0 || element == itemCount - 1 {
                    y += cellHeight
                    x = 0
                } else {
                    x += twoItemsInRowWidth
                }
            case .three:
                attributeForIndex.frame = CGRect(x: x,
                                                 y: y,
                                                 width: threeItemsInRowWidth,
                                                 height: cellHeight)
                if (element + 1) % threeColumns == 0 || element == itemCount - 1 {
                    y += cellHeight
                    x = 0
                } else {
                    x += threeItemsInRowWidth
                }
            case .four:
                attributeForIndex.frame = CGRect(x: x,
                                                 y: y,
                                                 width: fourItemsInRowWidth,
                                                 height: cellHeight)
                if (element + 1) % fourColumns == 0 || element == itemCount - 1 {
                    y += cellHeight
                    x = 0
                } else {
                    x += fourItemsInRowWidth
                }
            }
            cacheAttributes[indexPath] = attributeForIndex
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter {
            rect.intersects($0.frame)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: (collectionView?.frame.width)!, height: totalCellsHeight)
    }
}
