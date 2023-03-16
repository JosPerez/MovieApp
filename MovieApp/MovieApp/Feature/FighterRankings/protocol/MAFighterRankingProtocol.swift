//
//  MAFighterRankingProtocol.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//

import UIKit
import BackServices
protocol MAFighterRankingViewProtocol:BaseControllerProtocol {
    var presenter: MAFighterRankingPresenterProtocol? { get set }
    var headerData: [HeaderData] { get set }
    func setupHeaderData(entity: [HeaderData])
}
protocol MAFighterRankingPresenterProtocol {
    var view: MAFighterRankingViewProtocol? { get set }
    var interactor: MAFighterRankingInputInteractorProtocol? { get set }
    var router: MAFighterRankingRouterProtocol? { get set }
    var fighterName: String? { get set }
    func getRankings()
    func getFightersBy(name: String, id: Int)
}
protocol MAFighterRankingInputInteractorProtocol {
    var presenter: MAFighterRankingOutputInteractorProtocol? { get set }
    func getRankings()
    func getFightersBy(id: Int)
}
protocol MAFighterRankingOutputInteractorProtocol {
    func responseRankingsSuccess(entity: [BSRankingResponse])
    func responseRankingsFailed(message: String)
    func responseFightersStatsSuccess(entity: BSFighterStatEntity)
    func responseFightersStatsError(message: String)
}
protocol MAFighterRankingRouterProtocol {
    var presenter: MAFighterRankingPresenterProtocol? { get set }
    var view: MAFighterRankingsVC? { get }
    static func createView() -> UIViewController
    func moveToFighterStats(name: String, entity: BSFighterStatEntity)
}

