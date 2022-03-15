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
    /// Información para pintar las celdas
    var dataSource: [MATVShowDataSource] { get }
    /// Función que obtiene los programas de televisión
    /// - Parameter list: Lista con los programa de televisión
    func responseSuccessTVShows(list: [MATVShowDataSource])
    /// Función que obtiene los programas de televisión favoritos.
    /// - Parameter list: Lista con los programa de televisión
    func responseSuccessFavoriteTVShows(list: [MATVShowDataSource])
    /// Función que obtiene el error respuesta
    /// - Parameters  :
    ///  - messaage: Mensaje del servicio.
    ///  - show: Indica si es un error
    func responseFailedTVShows(message: String)
    /// Función que muestra toast para mensajes.
    /// - Parameters  :
    ///  - messaage: Mensaje del servicio.
    ///  - isError: Indica si es un error
    func showMessage(message: String, isError: Bool)
}
protocol MAHomePresenterProtocol {
    /// Referencia del view
    var view: MAHomeViewProtocol? { get }
    /// Referencia del router
    var router: MAHomeRouterProtocol? { get }
    /// Referencia del interactor
    var interactor: MAHomeInputInteractorProtocol? { get }
    /// Información de los show
    var dataSource: [BSTVShowsEntity]? { get }
    /// Fluijo a seguir
    var flow: MAShowFlow { get }
    /// Función que obtiene los programas de televisión
    func getTVShows()
    /// Función que obtiene los programas de televisión
    func getFavoriteTVShows()
    /// Función que guarda información de programa favorito
    /// - Parameter tvshow: Información del programa de televisión.
    func saveFavorite(tvshow: BSTVShowsEntity)
    /// Función que elimina información de programa favorito
    /// - Parameter tvshow: Información del programa de televisión.
    func deleteFavorite(tvshow: BSTVShowsEntity)
}
protocol MAHomeRouterProtocol {}
protocol MAHomeInputInteractorProtocol {
    /// Referencia del presenter
    var presenter: MAHomeOutputInteractorProtocol? { get }
    /// Función que obtiene los programas de televisión
    func getTVShows()
    /// Función que obtiene los programas de televisión
    func getFavoriteTVShows()
    /// Función que guarda información de programa favorito
    /// - Parameter tvshow: Información del programa de televisión.
    func saveFavorite(tvshow: BSTVShowsEntity)
    /// Función que elimina información de programa favorito
    /// - Parameter tvshow: Información del programa de televisión.
    func deleteFavorite(tvshow: BSTVShowsEntity)
}
protocol MAHomeOutputInteractorProtocol {
    /// Función que obtiene los programas de televisión
    /// - Parameter list: Lista con los programa de televisión
    func responseSuccessTVShows(list: [BSTVShowsEntity])
    /// Función que obtiene los programas de televisión
    /// - Parameter list: Lista con los programa de televisión
    func responseSuccessFavoriteTVShows(list: [BSTVShowsEntity])
    /// Función que obtiene el error respuesta
    ///   - Parameter message: Mensaje del servicio
    func responseFailedTVShows(message: String?)
    /// Función con respuesta exitosa al almacenar entidad
    ///  - Parameter message: Mensaje del servicio
    func storedResponseSuccess(message: String?)
    /// Función con respuesta fallida al almacenar entidad
    ///  - Parameter message: Mensaje del servicio
    func storedResponseFailed(message: String?)
    
}
