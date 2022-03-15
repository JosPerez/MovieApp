//
//  MATVShowDetailRouter.swift
//  MovieApp
//
//  Created by jose perez on 15/03/22.
//
import Foundation
import UIKit
final class MATVShowDetailRouter: MATVShowDetailRouterProtocol {
    /// Controlador de la  vista
    var view: MATVShowDetailVC
    /// Presenter
    private var presenter: MATVShowDetailPresenter
    /// Interactor
    private var interactor: MATVShowDetailInteractor
    /// Inicializador
    init(entity: MATVShowDataSource) {
        self.view = MATVShowDetailVC()
        self.presenter = MATVShowDetailPresenter()
        self.interactor = MATVShowDetailInteractor()
        /// Configuración vista
        view.presenter = presenter
        /// Configuración presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        presenter.entity = entity
        /// Configuración interactor
        interactor.presenter = presenter
    }
    func openBrowserWith(id: String) {
        let mainURL = "https://www.imdb.com/title/" + id
        print(mainURL)
        if let url = URL(string: mainURL) {
            UIApplication.shared.open(url)
        } else {
            view.showMessageFailed(message: "Link fallido.")
        }
    }
}
