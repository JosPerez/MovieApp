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
        self.view?.startLoading()
        interactor?.getFighters()
    }
    func getFightersBy(id: Int) {
        self.view?.startLoading()
        self.currentFigtherId = id
        interactor?.getFightersBy(id: id)
    }
}
extension MAFighterHomePresenter: MAFighterHomeOutputInteractorProtocol {
    func responseFightersSuccess(entity: [BSFighterEntity]) {
        self.view?.stopLoading()
        self.dataSource = entity
        self.view?.reloadFighterTable()
    }
    func responseFightersStatsSuccess(entity: BSFighterStatEntity) {
        self.view?.stopLoading()
        if let id = currentFigtherId {
            self.router?.moveToFighterStats(id: id, entity: entity)
        }
    }
    func responseFightersStatsError(message: String) {
        self.view?.stopLoading()
        self.view?.showMainAlert(description: message, complation: nil)
        self.view?.fighterServiceFailed()
    }
}
