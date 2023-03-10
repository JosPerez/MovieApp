//
//  MAFighterTableCell.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices

final class MAFighterTableCell: UITableViewCell {
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var extraInfoLbl:UILabel!
    @IBOutlet weak var weightLbl:UILabel!
    @IBOutlet weak var nicknameLbl:UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(entity: BSFighterEntity) {
        self.nameLbl.text = entity.firstName + " " + entity.lastName.valueOrEmtpy()
        self.weightLbl.text = entity.weightClass.valueOrEmtpy()
        self.extraInfoLbl.text = "Debut: \(entity.debut.valueOrEmtpy())"
        self.nicknameLbl.text = entity.nickname.valueOrEmtpy()
    }
}
