//
//  MAGenderLayers.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
//

import Foundation
import UIKit
final class FemaleLayer: CAShapeLayer {

    override var frame: CGRect {
        didSet{
            self.draw()
        }
    }

    private func draw() {
        self.lineWidth = 3.0
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.black.cgColor

        let path = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = (sideLength / 2.0 - self.lineWidth) * 0.6
        let circleCenterY = self.bounds.midY * 0.8

        path.addArc(withCenter: CGPoint(x:self.bounds.midX, y:circleCenterY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)

        let circleBottomY = circleCenterY + circlesRadius
        path.move(to: CGPoint(x: self.bounds.midX, y: circleBottomY))
        path.addLine(to: CGPoint(x: self.bounds.midX, y: circleBottomY + circlesRadius))
        path.move(to: CGPoint(x: self.bounds.midX * 0.6, y: circleBottomY + circlesRadius * 0.5))
        path.addLine(to: CGPoint(x: self.bounds.midX * 1.4, y: circleBottomY + circlesRadius * 0.5))

        self.path = path.cgPath
    }
}
final class MaleLayer: CAShapeLayer {
    override var frame: CGRect {
        didSet{
            self.draw()
        }
    }

    private func draw() {
        self.lineWidth = 2.0
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.black.cgColor

        let path = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = (sideLength / 2.0 - self.lineWidth) * 0.6
        let circleCenterX = self.bounds.midX * 0.9
        let circleCenterY = self.bounds.midY * 1.2

        path.addArc(withCenter: CGPoint(x:circleCenterX, y:circleCenterY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)

        let circleRightTopX = circleCenterX + circlesRadius * 0.686
        let circleRightTopY = circleCenterY - circlesRadius * 0.686
        let lineLength = circlesRadius * 0.7
        path.move(to: CGPoint(x: circleRightTopX, y: circleRightTopY))
        path.addLine(to: CGPoint(x: circleRightTopX + lineLength, y: circleRightTopY - lineLength))
        path.move(to: CGPoint(x: circleRightTopX, y: circleRightTopY - lineLength))
        path.addLine(to: CGPoint(x: circleRightTopX + lineLength + self.lineWidth / 2.0, y: circleRightTopY - lineLength))
        path.move(to: CGPoint(x: circleRightTopX + lineLength, y: circleRightTopY - lineLength))
        path.addLine(to: CGPoint(x: circleRightTopX + lineLength , y: circleRightTopY))

        self.path = path.cgPath
    }
}
