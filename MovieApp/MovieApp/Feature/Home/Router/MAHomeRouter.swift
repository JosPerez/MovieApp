//
//  MAHomeRouter.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
import UIKit
final class MAHomeRouter: MAHomeRouterProtocol {
    /// Controlador de la  vista
    var view: MAHomeVC
    /// Presenter
    private var presenter: MAHomePresenter
    /// Interactor
    private var interactor: MAHomeInteractor
    /// Inicializador
    init(flow: MAShowFlow) {
        self.view = MAHomeVC()
        self.presenter = MAHomePresenter()
        self.interactor = MAHomeInteractor()
        /// Configuración vista
        view.presenter = presenter
        view.flow = flow
        /// Configuración presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        presenter.flow = flow
        /// Configuración interactor
        interactor.presenter = presenter
    }
    func showShowDetail(entity: MATVShowDataSource) {
        let router = MATVShowDetailRouter(entity: entity)
        view.navigationController?.pushViewController(router.view, animated: true)
    }
}
