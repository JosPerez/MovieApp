//
//  MAThreeStatGraphCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
//
import UIKit
import BackServices
final class MAThreeStatGraphCell: UITableViewCell {
    let categoryColors: [UIColor] = [.blue,.green,.yellow]
    var parts:[Part] = []
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var firstCategoryLbl: UILabel!
    @IBOutlet private weak var secondCategoryLbl: UILabel!
    @IBOutlet private weak var ThridCategoryLbl: UILabel!
    @IBOutlet private weak var firstCategoryView: UIView!
    @IBOutlet private weak var secondCategoryView: UIView!
    @IBOutlet private weak var thridCategoryView: UIView!
    @IBOutlet private weak var ringView: RingView!
    func setupCell(entity: MAThreeStatGraph) {
        firstCategoryView.backgroundColor = categoryColors[0]
        secondCategoryView.backgroundColor = categoryColors[1]
        thridCategoryView.backgroundColor = categoryColors[2]
        titleLbl.text = entity.seccionTitle
        firstCategoryLbl.text = getCategoryFullText(title: entity.title[0], percetange: entity.values[0].percentage, quantity: entity.values[0].quantity)
        secondCategoryLbl.text = getCategoryFullText(title: entity.title[1], percetange: entity.values[1].percentage, quantity: entity.values[1].quantity)
        ThridCategoryLbl.text = getCategoryFullText(title: entity.title[2], percetange: entity.values[2].percentage, quantity: entity.values[2].quantity)
        for index in 0..<categoryColors.count {
            let part = Part(quantity: Double(entity.values[index].quantity) ?? 0.0, color: categoryColors[index], name: entity.title[index])
            parts.append(part)
        }
        ringView.ringWidth = 14
        ringView.dataSource = self
    }
    func getCategoryFullText(title: String, percetange: String, quantity: String) -> String {
        var per = percetange.replacingOccurrences(of: "(", with: "")
        per = per.replacingOccurrences(of: ")", with: "")
        per = per.replacingOccurrences(of: "%", with: "")
        return "\(title): \(quantity) (\(per)%)"
    }
}
extension MAThreeStatGraphCell: RingViewDataSource {
    func numberOfParts(in ringView: BackServices.RingView) -> Int {
        return parts.count
    }
    
    func ringView(_ ringView: BackServices.RingView, partAt index: Int) -> BackServices.Part {
        return parts[index]
    }
    
    func ringView(_ ringView: BackServices.RingView, labelsFor centerLabel: inout (up: UILabel, down: UILabel)) {
        centerLabel.up.text = "⭐"
        var emoticon = ""
        var text = ""
        if parts.count == 3,(parts[0].quantity > 0 || parts[1].quantity > 0 || parts[1].quantity > 0) {
            emoticon = "⭐"
            let bigger = max(parts[0].quantity, parts[1].quantity, parts[2].quantity)
            if bigger == parts[0].quantity {
                text =  parts[0].name
            } else if bigger == parts[1].quantity {
                text =  parts[1].name
            } else if bigger == parts[2].quantity {
                text =  parts[2].name
            }
        }
        centerLabel.up.text = emoticon
        centerLabel.down.text = text
    }
}
