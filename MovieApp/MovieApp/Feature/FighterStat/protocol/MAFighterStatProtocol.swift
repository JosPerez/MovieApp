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
}
protocol MAFighterStatPresenterProtocol {
    var view: MAFighterStatViewProtocol? { get set }
    var interactor: MAFighterStatInputInteractorProtocol? { get set }
    var router: MAFighterStatRouterProtocol? { get set }
    var entity: BSFighterStatEntity? { get set }
    var dataSource: [MAStasBase]? { get set }
    func setupDataSource()
}
protocol MAFighterStatRouterProtocol {
    var presenter: MAFighterStatPresenterProtocol? { get set }
    var view: MAFighterStatVC? { get }
    static func createView(fighterName: String, entity: BSFighterStatEntity) -> UIViewController
}
protocol MAFighterStatInputInteractorProtocol {
    var presenter: MAFighterStatOutputInteractorProtocol? { get set }
}
protocol MAFighterStatOutputInteractorProtocol {
}
