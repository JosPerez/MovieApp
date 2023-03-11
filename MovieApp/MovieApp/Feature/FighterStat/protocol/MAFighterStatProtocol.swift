//
//  MAFighterStatProtocol.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//

import UIKit
import BackServices
protocol MAFighterStatViewProtocol:BaseControllerProtocol {
    var presenter: MAFighterStatPresenterProtocol? { get set }
    var fighterName: String? { get set }
    func setupDataSourceSuccess()
    func responseFightsSuccess()
}
protocol MAFighterStatPresenterProtocol {
    var view: MAFighterStatViewProtocol? { get set }
    var interactor: MAFighterStatInputInteractorProtocol? { get set }
    var router: MAFighterStatRouterProtocol? { get set }
    var entity: BSFighterStatEntity? { get set }
    var dataSource: [MAStatsBase]? { get set }
    var history: BSFighterHistory? { get set }
    func setupDataSource()
    func getFightsBy(id: Int)
    func showFights()
}
protocol MAFighterStatRouterProtocol {
    var presenter: MAFighterStatPresenterProtocol? { get set }
    var view: MAFighterStatVC? { get }
    static func createView(fighterName: String, entity: BSFighterStatEntity) -> UIViewController
    func showFights(entity: BSFighterHistory)
}
protocol MAFighterStatInputInteractorProtocol {
    var presenter: MAFighterStatOutputInteractorProtocol? { get set }
    func getFightsBy(id: Int)
}
protocol MAFighterStatOutputInteractorProtocol {
    func responseFightsSuccess(entity: BSFighterHistory)
    func responseFightsFailed(message: String)
}
