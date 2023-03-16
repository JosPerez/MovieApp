//
//  MAFighterRankingRouter.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterRankingRouter: MAFighterRankingRouterProtocol {
    var view: MAFighterRankingsVC?
    var presenter: MAFighterRankingPresenterProtocol?
    static func createView() -> UIViewController {
        let view = MAFighterRankingsVC()
        let presenter = MAFighterRankingPresenter()
        let interactor = MAFighterRankingInteractor()
        let router = MAFighterRankingRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        router.presenter = presenter
        return view
    }
    func moveToFighterStats(name: String, entity: BSFighterStatEntity) {
        if let view = view {
            let name = name
            let vc = MAFighterStatRouter.createView(fighterName: name,entity: entity)
            view.tabBarController?.tabBar.isHidden = true
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
