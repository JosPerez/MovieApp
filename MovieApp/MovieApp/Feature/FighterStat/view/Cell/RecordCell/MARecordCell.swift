//
//  MARecordCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
//
import UIKit
final class MARecordCell: UITableViewCell {
    @IBOutlet private weak var recordLbl: UILabel!
    func setupCell(record: String) {
        recordLbl.text = record
    }
}
