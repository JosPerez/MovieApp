//
//  MAFighterHistoryProtocol.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
protocol MAFighterHistoryViewProtocol:BaseControllerProtocol {
    var presenter: MAFighterHistoryPresenterProtocol? { get set }
    var fighterName: String? { get set }
}
protocol MAFighterHistoryPresenterProtocol {
    var view: MAFighterHistoryViewProtocol? { get set }
    var interactor: MAFighterHistoryInputInteractorProtocol? { get set }
    var router: MAFighterHistoryRouterProtocol? { get set }
    var history: BSFighterHistory? { get set }
}
protocol MAFighterHistoryRouterProtocol {
    var presenter: MAFighterHistoryPresenterProtocol? { get set }
    var view: MAFighterHistoryVC? { get }
    static func createView(fighterName: String, entity: BSFighterHistory) -> UIViewController
}
protocol MAFighterHistoryInputInteractorProtocol {
    var presenter: MAFighterHistoryOutputInteractorProtocol? { get set }
}
protocol MAFighterHistoryOutputInteractorProtocol {

}
