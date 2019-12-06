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
        image.image = UIImage(named: "myPhoto")
        image.backgroundColor = .black
    }
    override func layoutSubviews() {
        image.frame = self.frame
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        
        image.layer.cornerRadius = self.frame.size.width / 2
        image.layer.masksToBounds = true
    }
}

