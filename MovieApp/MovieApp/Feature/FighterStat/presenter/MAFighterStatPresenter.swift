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
        if let record = entity?.record, let avgFight = entity?.avgFightTime {
            let record = MAStasBase(name: "Record", type: .record(record, avgFight))
            dataSource?.append(record)
        }
        if let entity = entity, let sLanded = entity.sigStrikingLanded, let sThrowed = entity.sigStrikingThrow {
            let strikes = MAStasBase(name: "Strikes", type: .circularGraph(sLanded, sThrowed, .strike))
            dataSource?.append(strikes)
        }
        if let entity = entity, let sLanded = entity.takedownsLanded, let sThrowed = entity.takedownsAttempted {
            let strikes = MAStasBase(name: "Takedowns", type: .circularGraph(sLanded, sThrowed, .takedowns))
            dataSource?.append(strikes)
        }
        if let entity = entity?.sigStrikingLandedByPos, let title = entity.title, let content = entity.content {
            let titles: [String] = content.map({ $0.name })
            let values: [MADetailStat] = content.map({ MADetailStat(percentage: $0.value.percentage, quantity: $0.value.number) })
            let graph = MAThreeStatGraph(seccionTitle: title, title: titles, values: values)
            let position = MAStasBase(name: title, type: .ThreeStatGraph(graph))
            dataSource?.append(position)
        }
        if let entity = entity?.sigStrikingByTarget {
            let name = "Golpes Sig. por Objetivo"
            let titles = ["Head","Body","Legs"]
            let heads = MADetailStat(percentage: entity.head.percentage, quantity: entity.head.value)
            let bodies = MADetailStat(percentage: entity.body.percentage, quantity: entity.body.value)
            let leg = MADetailStat(percentage: entity.legs.percentage, quantity: entity.legs.value)
            let values = [heads, bodies, leg]
            let graph = MAThreeStatGraph(seccionTitle: name, title: titles, values: values)
            let target = MAStasBase(name: name, type: .ThreeStatGraph(graph))
            dataSource?.append(target)
        }
        self.view?.setupDataSourceSuccess()
    }
}
extension MAFighterStatPresenter: MAFighterStatOutputInteractorProtocol {}
