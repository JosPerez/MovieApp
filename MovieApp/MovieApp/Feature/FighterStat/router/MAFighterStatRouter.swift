//
//  MAFighterStatRouter.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterStatRouter: MAFighterStatRouterProtocol {    
    var view: MAFighterStatVC?
    var presenter: MAFighterStatPresenterProtocol?
    
    static func createView(fighterName: String, entity: BSFighterStatEntity) -> UIViewController {
        let view = MAFighterStatVC()
        let presenter = MAFighterStatPresenter()
        let interactor = MAFighterStatInteractor()
        let router = MAFighterStatRouter()
        view.fighterName = fighterName
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.entity = entity
        interactor.presenter = presenter
        router.view = view
        router.presenter = presenter
        return view
    }
}
