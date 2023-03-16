//
//  MALoaderView.swift
//  MovieApp
//
//  Created by jose perez on 12/03/23.
//
import UIKit

class MALoaderView: UIView {
    let circleLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        isUserInteractionEnabled = false
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: 30, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.purple.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 5.0
        circleLayer.strokeEnd = 0.0
        layer.addSublayer(circleLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        // Set window level to be above all other views
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(self)
            self.window?.windowLevel = window.windowLevel + 1
        }
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.repeatCount = .infinity
        circleLayer.add(animation, forKey: "strokeEnd")
    }

    func stopAnimating() {
        circleLayer.removeAllAnimations()
        circleLayer.removeFromSuperlayer()
        self.removeFromSuperview()
    }
}
