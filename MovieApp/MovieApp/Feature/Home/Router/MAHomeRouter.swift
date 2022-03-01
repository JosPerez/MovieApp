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
    init() {
        self.view = MAHomeVC()
        self.presenter = MAHomePresenter()
        self.interactor = MAHomeInteractor()
        /// Configuración vista
        view.presenter = presenter
        /// Configuración presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        /// Configuración interactor
        interactor.presenter = presenter
    }
}
