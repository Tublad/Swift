
import UIKit
import ImageViewer_swift

class PhotoCollectionView: UICollectionView {
    
    //MARK: получаю фотографии и начинаю их обрабатывать для предствляния
    
    var images: [UIImage] = [UIImage]() {
        didSet {
            self.delegate = self
            self.dataSource = self
            register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIndefender )
        }
    }
}

//MARK: добавляю в ячейку полученные данные

extension PhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIndefender, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.galleryPhoto.image = images[indexPath.row]
        cell.galleryPhoto.setupImageViewer(images: images, initialIndex: indexPath.item, options: [.theme(.dark)])
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
}
