//
//  MAStatCircularCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
import Foundation
enum MAStatType: String{
    case strike = "Striking"
    case takedowns = "Takedowns"
    case strikesPerMin = "Strikes Per Minute"
    case takedownsDefence = "Defence Takedowns"
    case strikingDefence = "Defence Striking"
}
struct MAStatsBase {
    enum EntityType {
        case record(String, String)
        case circularGraph(Double, Double, MAStatType)
        case ThreeStatGraph(MAThreeStatGraph)
        case barStatCell(MABarStatGraph)
    }
    var name: String
    var type: EntityType
}
struct MAThreeStatGraph {
    var seccionTitle: String
    var title: [String]
    var values: [MADetailStat]
}
struct MADetailStat {
    var percentage: String
    var quantity: String
}
struct MABarStatGraph {
    var values: [MABarStat]
}
struct MABarStat {
    var name: String
    var quantity: Double
}
