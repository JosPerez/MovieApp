//
//  MABarStatCell.swift
//  MovieApp
//
//  Created by jose perez on 13/03/23.
//

import UIKit
import BackServices

class GraphTableViewCell: UITableViewCell {
    @IBOutlet weak var graphView: VBSBarGraphView!
    var entity: [MABarStat] = []
    func setupCell(entity: [MABarStat]) {
        self.entity = entity
        // Set data source for BarGraphView
        graphView.dataSource = self
        // Redraw BarGraphView
        graphView.setNeedsDisplay()
    }
}

// Implement BarGraphViewDataSource protocol
extension GraphTableViewCell: VBSBarGraphViewDataSource {
    func numberOfBars(in barGraphView: BackServices.VBSBarGraphView) -> Int {
        return entity.count
    }
    
    func barGraphView(_ barGraphView: BackServices.VBSBarGraphView, nameForBarAt index: Int) -> String {
        return entity[index].name
    }
    
    func barGraphView(_ barGraphView: BackServices.VBSBarGraphView, quantityForBarAt index: Int) -> Double {
        return entity[index].quantity
    }
    

}
