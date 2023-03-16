//
//  MAFighterRankingInterctor.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import Foundation
import BackServices
final class MAFighterRankingInteractor: MAFighterRankingInputInteractorProtocol {
    var presenter: MAFighterRankingOutputInteractorProtocol?
    var facade: BSFighterFacade
    public init() {
        facade = BSFighterFacade(url: MAUrlsServices.fighterUrl)
        facade.delegate = self
    }
    public func getRankings() {
        facade.getRankings()
    }
    public func getFightersBy(id: Int) {
        facade.getFighterStatsBy(id: id)
    }
}
extension MAFighterRankingInteractor: BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSRankingResponse.self):
            if let response = entity as? [BSRankingResponse] {
                self.presenter?.responseRankingsSuccess(entity: response)
            } else if let error = entity as? BSErrorBase {
                self.presenter?.responseRankingsFailed(message: error.message ?? "No se encontró")
            }
        case String(describing: BSFighterStatEntity.self):
            if let response = entity as? BSFighterStatEntity {
                self.presenter?.responseFightersStatsSuccess(entity: response)
            } else if let error = entity as? BSErrorBase {
                self.presenter?.responseFightersStatsError(message: error.message ?? "No Encontrado")
            }
        default: break
        }
    }
}
