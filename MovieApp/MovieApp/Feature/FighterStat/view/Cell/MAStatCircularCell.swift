//
//  MAStatCircularCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
//
import UIKit
import BackServices
final class MAStatCircularCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet private weak var circularView: RingView!
    @IBOutlet private weak var landedLbl: UILabel!
    @IBOutlet private weak var throwedLbl: UILabel!
    @IBOutlet private weak var colorLandedView: UIView!
    @IBOutlet private weak var colorThrowedView: UIView!
    var parts: [Part] = []
    func setupCell(landed: Int, throwed: Int, type: MAStatType) {
        titleLbl.text = "\(type.rawValue) Efficiency"
        let partLanded = Part(quantity: Double(landed), color: .green, name: "\(type.rawValue) Landed")
        let partThrowed = Part(quantity: Double(throwed), color: .red, name: "\(type.rawValue) Thrown")
        parts = [partLanded,partThrowed]
        circularView.ringWidth = 14
        circularView.dataSource = self
        landedLbl.text = "\(type.rawValue) Landed:\n\(landed)"
        colorLandedView.backgroundColor = .green
        throwedLbl.text = "\(type.rawValue) Throwed:\n\(throwed)"
        colorThrowedView.backgroundColor = .red
    }
}
extension MAStatCircularCell: RingViewDataSource {
    func numberOfParts(in ringView: RingView) -> Int {
        return parts.count
    }
    
    func ringView(_ ringView: RingView, partAt index: Int) -> Part {
        return parts[index]
    }
    
    func ringView(_ ringView: RingView, labelsFor centerLabel: inout (up: UILabel, down: UILabel)) {
        centerLabel.up.text = "Efficiency"
        centerLabel.up.font = UIFont.boldSystemFont(ofSize: 16)
        let total = parts[0].quantity + parts[1].quantity
        let landed = parts[0].quantity
        var percentage = 0.0
        if total > 0 {
            percentage =  (landed / total) * 100
            percentage = Double(round(100 * percentage) / 100)
        }
        centerLabel.down.text = "\(percentage)%"
        centerLabel.down.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
