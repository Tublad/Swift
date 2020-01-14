import UIKit

class PreviewViewController: UIViewController {
     
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    var photoUser: [UIImage]!
    
    let photoUsers = [UIImage(named: "image1"), UIImage(named: "image2"),UIImage(named: "image3"), UIImage(named: "image4"),UIImage(named: "image1"), UIImage(named: "image2"),UIImage(named: "image3"), UIImage(named: "image4"),UIImage(named: "image1"), UIImage(named: "image2"),UIImage(named: "image3"), UIImage(named: "image4"),UIImage(named: "image1"), UIImage(named: "image2"),UIImage(named: "image3"), UIImage(named: "image4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = photoUsers.count
    }
}

extension PreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullPhoto", for: indexPath) as? PreviewViewCell else { return UICollectionViewCell() }
            cell.imageFull.image = photoUsers[indexPath.row]
            pageView.currentPage = indexPath.row
        return cell
    }
}


extension PreviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    } 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}

