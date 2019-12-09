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
        image.image = UIImage(named: "myPhoto")
        addSubview(image)
    }
    override func layoutSubviews() {
        image.frame = bounds
        layer.backgroundColor = UIColor.clear.cgColor
        //    layer.shadowColor = UIColor.gray.cgColor
        //    layer.shadowOffset = CGSize(width: 0, height: 1.0)
        //    layer.shadowOpacity = 1.0
        //    layer.shadowRadius = 10
        // убрал тень, так как она сейчас не в теме ))
        
        image.layer.cornerRadius = bounds.size.width / 2
        image.layer.masksToBounds = true
    }
}

