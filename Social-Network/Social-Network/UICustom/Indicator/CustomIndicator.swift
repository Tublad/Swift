
import UIKit

class CustomIndicator: UIView {
    var viewLoad: UIView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
    }

    func addView() {
        viewLoad = UIView(frame: self.frame)
        addSubview(viewLoad)
    }

    override func layoutSubviews() {
        viewLoad.frame = bounds
        layer.backgroundColor = UIColor.clear.cgColor

        viewLoad.layer.cornerRadius = bounds.size.width / 2
        viewLoad.backgroundColor = .darkGray
        viewLoad.layer.masksToBounds = true
    }
}
