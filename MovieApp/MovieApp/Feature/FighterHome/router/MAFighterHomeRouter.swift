//
//  MAFighterHomeRouter.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterHomeRouter: MAFighterHomeRouterProtocol {
    var view: MAFighterHomeVC?
    var presenter: MAFighterHomePresenterProtocol?
    static func createView() -> UIViewController {
        let view = MAFighterHomeVC()
        let presenter = MAFighterHomePresenter()
        let interactor = MAFighterHomeInteractor()
        let router = MAFighterHomeRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        return view
    }
    func moveToFighterStats(id: Int, entity: BSFighterStatEntity) {
        if let view = view {
            let name = (self.presenter?.dataSource[id - 1].firstName ?? "") + " "  + (self.presenter?.dataSource[id - 1].lastName ?? "")
            let vc = MAFighterStatRouter.createView(fighterName: name,entity: entity)
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
