//
//  MAFighterRankingEntity.swift
//  MovieApp
//
//  Created by jose perez on 15/03/23.
//
import Foundation
import BackServices
class HeaderData {
    var title: String
    var imgUrl:String
    var isExpanded: Bool
    var details: [BSFighterRanking]
    init(entity: BSRankingResponse) {
        self.title = entity.title
        self.imgUrl = entity.imgUrl
        self.isExpanded = false
        self.details = entity.fighters
    }
}
