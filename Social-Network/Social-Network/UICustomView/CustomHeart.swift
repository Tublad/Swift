import UIKit

class CustomHeart: UIView {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
      
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 30, y: 10)) // 1
        path.addLine(to: CGPoint(x: 50, y: 20)) // 2
        path.addLine(to: CGPoint(x: 70, y: 10))  // 3
        path.addLine(to: CGPoint(x: 90, y: 30)) // 4
        path.addLine(to: CGPoint(x: 80, y: 60)) // 5
        path.addLine(to: CGPoint(x: 50, y: 80)) // 6
        path.addLine(to: CGPoint(x: 20, y: 60)) // 7
        path.addLine(to: CGPoint(x: 10, y: 30)) // 8
        path.addLine(to: CGPoint(x: 30, y: 10)) // 9
        path.close()
        path.stroke()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer// вот и сердце, но не получается с ним работать
        setNeedsDisplay()
    }
}




