//
//  MAFighterFightCell.swift
//  MovieApp
//
//  Created by jose perez on 10/03/23.
//

import UIKit
import BackServices
final class MAFighterFightCell: UITableViewCell {
    @IBOutlet private weak var rivalLbl: UILabel!
    @IBOutlet private weak var eventLbl: UILabel!
    @IBOutlet private weak var resultLbl: UILabel!
    @IBOutlet private weak var resultView: UIView!
    @IBOutlet private weak var methodLbl: UILabel!
    @IBOutlet private weak var roundLbl: UILabel!
    @IBOutlet private weak var timeLbl: UILabel!
    
    func setup(entity: BSFightResponse) {
        self.rivalLbl.text = "VS \(entity.rival)"
        self.eventLbl.text = getEventTextCorrect(text: entity.event)
        self.resultLbl.text = entity.result.uppercased()
        setupResultColor(result: entity.result.uppercased())
        self.methodLbl.text = String(entity.method.split(separator: ")")[0]) + ")"
        self.roundLbl.text = entity.round
        self.timeLbl.text = entity.roundTime
    }
    func getEventTextCorrect(text: String) -> String {
        var parts = text.components(separatedBy: "/")
        var name = parts.removeFirst().trimmingCharacters(in: .whitespacesAndNewlines)
        let date = parts.joined(separator: "/")
        let month = String(name.suffix(3)) // Extract the last 3 characters of the name as month
        name = String(name.prefix(name.count - 3))
        return name + "\n" + month + "/" + date
    }
    func setupResultColor(result: String) {
        var color: UIColor = .gray
        switch result{
        case "WIN":
            color = .militaryGreen
        case "LOSS":
            color = .red
        default: color = .gray
        }
        self.resultView.backgroundColor = color
    }
}
