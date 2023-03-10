//
//  MARecordCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
//
import UIKit
final class MARecordCell: UITableViewCell {
    @IBOutlet weak var lossesLbl: UILabel!
    @IBOutlet weak var winsLbl: UILabel!
    @IBOutlet private weak var drawsLbl: UILabel!
    @IBOutlet private weak var avgTimeLbl: UILabel!
    func setupCell(record: String, avgFightTime:String) {
        let numRecord = record.split(separator: "(")[0]
        let recordArray = numRecord.split(separator: "-")
        winsLbl.text = String(recordArray[0])
        lossesLbl.text = String(recordArray[1])
        drawsLbl.text = String(recordArray[2])
        avgTimeLbl.text = avgFightTime
    }
}
