//
//  MAFighterHomeProtocol.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//

import UIKit
import BackServices
protocol MAFighterHomeViewProtocol:BaseControllerProtocol {
    var presenter: MAFighterHomePresenterProtocol? { get set }
    func reloadFighterTable()
}
protocol MAFighterHomePresenterProtocol {
    var view: MAFighterHomeViewProtocol? { get set }
    var interactor: MAFighterHomeInputInteractorProtocol? { get set }
    var router: MAFighterHomeRouterProtocol? { get set }
    var dataSource: [BSFighterEntity] { get set }
    var currentFigtherId: Int? { set get }
    func getFighters()
    func getFightersBy(id: Int)
}
protocol MAFighterHomeRouterProtocol {
    var presenter: MAFighterHomePresenterProtocol? { get set }
    var view: MAFighterHomeVC? { get }
    static func createView() -> UIViewController
    func moveToFighterStats(id: Int, entity: BSFighterStatEntity)
}
protocol MAFighterHomeInputInteractorProtocol {
    var presenter: MAFighterHomeOutputInteractorProtocol? { get set }
    func getFighters()
    func getFightersBy(id: Int)
}
protocol MAFighterHomeOutputInteractorProtocol {
    func responseFightersSuccess(entity: [BSFighterEntity])
    func responseFightersStatsSuccess(entity: BSFighterStatEntity)
    func responseFightersStatsError(message: String)
}
