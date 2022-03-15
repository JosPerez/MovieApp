//
//  MAHomeProtocol.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
import BackServices
protocol MAHomeViewProtocol {
    /// Referencia del presenter
    var presenter: MAHomePresenterProtocol? { get }
    /// Fluijo a seguir
    var flow: MAShowFlow { get }
    /// Función que obtiene los programas de televisión
    /// - Parameter list: Lista con los programa de televisión
    func responseSuccessTVShows(list: [MATVShowDataSource])
}
protocol MAHomePresenterProtocol {
    /// Referencia del view
    var view: MAHomeViewProtocol? { get }
    /// Referencia del router
    var router: MAHomeRouterProtocol? { get }
    var interactor: MAHomeInputInteractorProtocol? { get }
    /// Fluijo a seguir
    var flow: MAShowFlow { get }
    /// Función que obtiene los programas de televisión
    func getTVShows()
}
protocol MAHomeRouterProtocol {}
protocol MAHomeInputInteractorProtocol {
    /// Referencia del presenter
    var presenter: MAHomeOutputInteractorProtocol? { get }
    /// Función que obtiene los programas de televisión
    func getTVShows()
}
protocol MAHomeOutputInteractorProtocol {
    /// Función que obtiene los programas de televisión
    /// - Parameter list: Lista con los programa de televisión
    func responseSuccessTVShows(list: [BSTVShowsEntity])
    /// Función que obtiene el error respuesta
    func responseFailedTVShows()
}
