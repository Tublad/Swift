import UIKit

class CustomPhoto: UIView {
    var image: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addImage()
    }
    
    func addImage() {
        image = UIImageView(frame: frame)
        addSubview(image)
    }
    override func layoutSubviews() {
        image.frame = bounds
        layer.backgroundColor = UIColor.clear.cgColor
        
        image.layer.cornerRadius = bounds.size.width / 2
        image.layer.masksToBounds = true
    }
}

