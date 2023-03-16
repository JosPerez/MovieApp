//
//  MAFighterRankingPresenter.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import Foundation
import BackServices
final class MAFighterRankingPresenter: MAFighterRankingPresenterProtocol {
    var view: MAFighterRankingViewProtocol?
        var interactor: MAFighterRankingInputInteractorProtocol?
    var router: MAFighterRankingRouterProtocol?
    var fighterName: String?
    func getRankings() {
        self.view?.startLoading()
        self.interactor?.getRankings()
    }
    func getFightersBy(name: String,id: Int) {
        self.view?.startLoading()
        self.fighterName = name
        self.interactor?.getFightersBy(id: id)
    }
    private func configureHeaderData(entity: [BSRankingResponse]) {
        var headers:[HeaderData] = []
        for row in entity {
            let header = HeaderData(entity: row)
            headers.append(header)
        }
        self.view?.stopLoading()
        self.view?.setupHeaderData(entity: headers)
    }
}
extension MAFighterRankingPresenter: MAFighterRankingOutputInteractorProtocol {
    func responseFightersStatsSuccess(entity: BSFighterStatEntity) {
        self.view?.stopLoading()
        self.router?.moveToFighterStats(name: fighterName ?? "", entity: entity)
    }
    func responseFightersStatsError(message: String) {
        self.view?.stopLoading()
        print(message)
    }
    func responseRankingsSuccess(entity: [BSRankingResponse]) {
        configureHeaderData(entity: entity)
    }
    func responseRankingsFailed(message: String) {
        self.view?.stopLoading()
        print(message)
    }
}
