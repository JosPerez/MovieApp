//
//  MAFighterHomePresenter.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import Foundation
import BackServices
final class MAFighterHomePresenter: MAFighterHomePresenterProtocol {
    var currentFigtherId: Int?
    var view: MAFighterHomeViewProtocol?
    var interactor: MAFighterHomeInputInteractorProtocol?
    var router: MAFighterHomeRouterProtocol?
    var dataSource: [BSFighterEntity] = []
    func getFighters() {
        interactor?.getFighters()
    }
    func getFightersBy(id: Int) {
        self.currentFigtherId = id
        interactor?.getFightersBy(id: id)
    }
}
extension MAFighterHomePresenter: MAFighterHomeOutputInteractorProtocol {
    func responseFightersSuccess(entity: [BSFighterEntity]) {
        self.dataSource = entity
        self.view?.reloadFighterTable()
    }
    func responseFightersStatsSuccess(entity: BSFighterStatEntity) {
        if let id = currentFigtherId {
            self.router?.moveToFighterStats(id: id, entity: entity)
        }
    }
    func responseFightersStatsError(message: String) {
        self.view?.showMainAlert(description: message, complation: nil)
    }
}
