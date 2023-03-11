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
    var dataSource: [MAStatsBase]?
    var history: BSFighterHistory?
    func getFightsBy(id: Int) {
        interactor?.getFightsBy(id: id)
    }
    func showFights() {
        if let history = history {
            self.router?.showFights(entity: history)
        }
    }
    
    func setupDataSource() {
        dataSource = []
        if let record = entity?.record, let avgFight = entity?.avgFightTime {
            let record = MAStatsBase(name: "Record", type: .record(record, avgFight))
            dataSource?.append(record)
        }
        if let entity = entity, let sLanded = entity.sigStrikingLanded, let sThrowed = entity.sigStrikingThrow {
            let strikes = MAStatsBase(name: "Strikes", type: .circularGraph(Double(sLanded), Double(sThrowed), .strike))
            dataSource?.append(strikes)
        }
        if let entity = entity, let sLanded = entity.takedownsLanded, let sThrowed = entity.takedownsAttempted {
            let strikes = MAStatsBase(name: "Takedowns", type: .circularGraph(Double(sLanded), Double(sThrowed), .takedowns))
            dataSource?.append(strikes)
        }
        if let entity = entity, let sLanded = Double(entity.sigStrikingLandedMin ?? "0.0"), let sThrowed = Double(entity.sigStrikingRecievedMin ?? "0.0") {
            let strikes = MAStatsBase(name: "Strikes per minute", type: .circularGraph(sLanded, sThrowed, .strikesPerMin))
            dataSource?.append(strikes)
        }
        if let entity = entity?.sigStrikingLandedByPos, let title = entity.title, let content = entity.content {
            let titles: [String] = content.map({ $0.name })
            let values: [MADetailStat] = content.map({ MADetailStat(percentage: $0.value.percentage, quantity: $0.value.number) })
            let graph = MAThreeStatGraph(seccionTitle: title, title: titles, values: values)
            let position = MAStatsBase(name: title, type: .ThreeStatGraph(graph))
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
            let target = MAStatsBase(name: name, type: .ThreeStatGraph(graph))
            dataSource?.append(target)
        }
        if let value = entity?.takedownDefence {
            let name = "Defensa de Derribo"
            let defence = Double(value) ?? 0.0
            let failed = defence > 1 ? 100 - defence : 0.0
            let tkdwnDefence = MAStatsBase(name: name, type: .circularGraph(defence, failed, .takedownsDefence))
            dataSource?.append(tkdwnDefence)
        }
        if let value = entity?.strikingDefence {
            let name = "Defensa de Golpe"
            let defence = Double(value) ?? 0.0
            let failed = defence > 1 ? 100 - defence : 0
            let tkdwnDefence = MAStatsBase(name: name, type: .circularGraph(defence, failed, .strikingDefence))
            dataSource?.append(tkdwnDefence)
        }
        self.view?.setupDataSourceSuccess()
    }
}
extension MAFighterStatPresenter: MAFighterStatOutputInteractorProtocol {
    func responseFightsSuccess(entity: BSFighterHistory) {
        self.history = entity
        self.view?.responseFightsSuccess()
    }
    func responseFightsFailed(message: String) {
        self.view?.showToast(message: "No se encontro historial", font: UIFont.systemFont(ofSize: 18), isError: true)
    }
}
