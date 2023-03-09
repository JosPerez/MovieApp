//
//  MAFighterStatPresenter.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import Foundation
import BackServices
final class MAFighterStatPresenter: MAFighterStatPresenterProtocol {
    var view: MAFighterStatViewProtocol?
    var interactor: MAFighterStatInputInteractorProtocol?
    var router: MAFighterStatRouterProtocol?
    var entity: BSFighterStatEntity?
    var dataSource: [MAStasBase]?
    func setupDataSource() {
        dataSource = []
        if let record = entity?.record {
            let record = MAStasBase(name: "Record", type: .record(record))
            dataSource?.append(record)
        }
        if let entity = entity, let sLanded = entity.sigStrikingLanded, let sThrowed = entity.sigStrikingThrow {
            let strikes = MAStasBase(name: "Record", type: .circularGraph(sLanded, sThrowed, .strike))
            dataSource?.append(strikes)
        }
        if let entity = entity, let sLanded = entity.takedownsLanded, let sThrowed = entity.takedownsAttempted {
            let strikes = MAStasBase(name: "Record", type: .circularGraph(sLanded, sThrowed, .takedowns))
            dataSource?.append(strikes)
        }
        self.view?.setupDataSourceSuccess()
    }
}
extension MAFighterStatPresenter: MAFighterStatOutputInteractorProtocol {}
