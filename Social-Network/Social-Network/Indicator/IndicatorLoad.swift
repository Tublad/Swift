import UIKit

class Indicator: UIView {
    @IBOutlet weak var firstIndicator: CustomIndicator!
    @IBOutlet weak var secondIndicator: CustomIndicator!
    @IBOutlet weak var thirdIndicator: CustomIndicator!
    
    var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    func animation() {

        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: [.repeat, .autoreverse, .curveLinear],
                       animations: {
            self.firstIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.firstIndicator.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

        UIView.animate(withDuration: 0.4,
                       delay: 0.15,
                       options: [.repeat, .autoreverse, .curveLinear],
                       animations: {
            self.secondIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.secondIndicator.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

        UIView.animate(withDuration: 0.4,
                       delay: 0.3,
                       options: [.repeat, .autoreverse, .curveLinear],
                       animations: {
            self.thirdIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.thirdIndicator.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

    }

    func xibSetup() {
        contentView = loadXIB()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)

        animation()
    }

    func loadXIB() -> UIView {
        let bundle = Bundle(for: type(of: self) )
        let xib = UINib(nibName:  String(describing: type(of: self)), bundle: bundle)
        return xib.instantiate(withOwner: self, options: nil).first as! UIView
    }

}
