//
//  MAStatCircularCell.swift
//  MovieApp
//
//  Created by jose perez on 09/03/23.
import Foundation
enum MAStatType: String{
    case strike = "Striking"
    case takedowns = "Takedowns"
}
struct MAStasBase {
    enum EntityType {
        case record(String)
        case circularGraph(Int, Int, MAStatType)
    }
    var name: String
    var type: EntityType
}
