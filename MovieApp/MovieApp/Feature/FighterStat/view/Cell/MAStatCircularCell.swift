//
//  MAStatCircularCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
//
import UIKit
import BackServices
final class MAStatCircularCell: UITableViewCell {
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var circularView: RingView!
    @IBOutlet private weak var landedLbl: UILabel!
    @IBOutlet private weak var throwedLbl: UILabel!
    @IBOutlet private weak var colorLandedView: UIView!
    @IBOutlet private weak var colorThrowedView: UIView!
    var parts: [Part] = []
    var type: MAStatType = .strike
    func setupCell(landed: Double, throwed: Double, type: MAStatType) {
        self.type = type
        if type == .takedownsDefence || type == .strikingDefence {
            setupDefenceCell(landed: landed, throwed: throwed)
            return
        }
        let title = type == .strikesPerMin ? type.rawValue : "\(type.rawValue) Efficiency"
        titleLbl.text = title
        let partLanded = Part(quantity: landed, color: .green, name: "\(type.rawValue) Landed")
        let partThrowed = Part(quantity: throwed, color: .red, name: "\(type.rawValue) Thrown")
        parts = [partLanded,partThrowed]
        circularView.ringWidth = 18
        circularView.dataSource = self
        landedLbl.attributedText = attributedStringWithBoldSecondString("Landed:", "\(landed)")
        colorLandedView.backgroundColor = .green
        let secondValue = type == .strikesPerMin ? "Recieved:" : "Throw:"
        throwedLbl.attributedText = attributedStringWithBoldSecondString(secondValue, "\(throwed)")
        colorThrowedView.backgroundColor = .red
    }
    private func setupDefenceCell(landed: Double, throwed: Double) {
        let current:MAStatType = type == .strikingDefence ? .strike : .takedowns
        titleLbl.text = "\(current.rawValue) Defence"
        let partLanded = Part(quantity: landed, color: .green, name: "\(current.rawValue) Defended")
        let partThrowed = Part(quantity: throwed, color: .red, name: "\(current.rawValue) Failed")
        parts = [partLanded,partThrowed]
        circularView.ringWidth = 18
        circularView.dataSource = self
        landedLbl.attributedText =  attributedStringWithBoldSecondString("Defended:", "\(landed)%")
        colorLandedView.backgroundColor = .green
        throwedLbl.attributedText = attributedStringWithBoldSecondString("Passed:", "\(throwed)%")
        colorThrowedView.backgroundColor = .red
    }
    private func attributedStringWithBoldSecondString(_ firstString: String, _ secondString: String) -> NSAttributedString {
        let fullString = "\(firstString) \(secondString)"
        let attributedString = NSMutableAttributedString(string: fullString)
        let boldRange = (fullString as NSString).range(of: secondString)
        attributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: boldRange)
        return attributedString
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
        let total = parts[0].quantity + parts[1].quantity
        let landed = parts[0].quantity
        var percentage = 0.0
        if total > 0 {
            centerLabel.up.text = type == .takedownsDefence || type == .strikingDefence ? "Defence" : "Efficiency"
            centerLabel.up.font = UIFont.boldSystemFont(ofSize: 16)
            percentage =  (landed / total) * 100
            percentage = Double(round(100 * percentage) / 100)
            centerLabel.down.text = "\(percentage)%"
            centerLabel.down.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
}
