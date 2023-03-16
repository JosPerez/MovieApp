//
//  MARankCell.swift
//  MovieApp
//
//  Created by jose perez on 15/03/23.
//
import UIKit
import BackServices
final class MARankCell: UITableViewCell {
    @IBOutlet private weak var number: UILabel!
    @IBOutlet private weak var name: UILabel!
    func setupCell(entity: BSFighterRanking) {
        self.number.text = "\(entity.rank)"
        self.name.text = entity.name
    }
}
