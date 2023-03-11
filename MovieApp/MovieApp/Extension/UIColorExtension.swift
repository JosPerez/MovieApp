//
//  UIColorExtension.swift
//  MovieApp
//
//  Created by jose perez on 07/02/23.
//

import UIKit
import BackServices

extension UIColor {
    static var militaryGreen = UIColor(red: 0.0/255.0, green: 128.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
extension Part {
    static func randomPartGeneration(count: Int) -> [Part] {
        var parts = [Part]()
        for _ in 0..<count {
            let part = Part(quantity: Double.random(in: 100000000.00...1000000000.00), color: UIColor.randomColor(), name: String.randomString())
            parts.append(part)
        }
        return parts
    }
}
extension String {
    static func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let firstPart = String((0..<5).map{ _ in letters.randomElement()! })
        let secondPart = String((0..<5).map{ _ in letters.randomElement()! })
        return firstPart + " " + secondPart
    }
}
extension Optional where Wrapped == String {
    public func valueOrEmtpy() -> String {
        return self ?? ""
    }
}
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if newValue > 0 {
                self.clipsToBounds = true
                self.layer.cornerRadius = newValue
            } else {
                self.clipsToBounds = false
            }
        }
    }
}
