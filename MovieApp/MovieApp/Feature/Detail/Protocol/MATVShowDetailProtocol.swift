//
//  MATVShowDetailProtocol.swift
//  MovieApp
//
//  Created by jose perez on 15/03/22.
//
import Foundation
import BackServices
protocol MATVShowDetailViewProtocol {
    /// Referencia del presenter
    var presenter: MATVShowDetailPresenterProtocol? { get }
    /// Mostrar mensaje de acción exitoasa.
    ///  - Parameters
    ///  - message: Mensaje del servicio
    ///  - isFavorite: Es favorito para pintar imagen.
    func showMessageSucces(message: String, isFavorite: Bool)
    /// Mostrar mensaje de acción exitoasa.
    ///  - Parameter message: Mensaje del servicio
    func showMessageFailed(message: String)
}
protocol MATVShowDetailPresenterProtocol {
    /// Referencia del view
    var view: MATVShowDetailViewProtocol? { get }
    /// Referencia del router
    var router: MATVShowDetailRouterProtocol? { get }
    /// Referencia del interactor
    var interactor: MATVShowDetailInputInteractorProtocol? { get }
    /// Enitidad para pintar la la vista
    var entity: MATVShowDataSource? { get set }
    /// Agreagar entidad a favoritos
    func saveFavorite()
    /// Eliminar entidad a favoritos
    func deleteFavorite()
    /// Abrir Navegador con link
    /// - Parameter id: Identificadro con de la pagina
    func openBrowserWith(id: String)
}
protocol MATVShowDetailRouterProtocol {
    /// Abrir Navegador con link
    /// - Parameter id: Identificadro con de la pagina
    func openBrowserWith(id: String)
}
protocol MATVShowDetailInputInteractorProtocol {
    /// Referencia del presenter
    var presenter: MATVShowDetailOutputInteractorProtocol? { get }
    /// Agreagar entidad a favoritos
    ///  - Parameter tvshow: Informcación del tvshow.
    func saveFavorite(tvshow: BSTVShowsEntity)
    /// Eliminar entidad a favoritos
    ///  - Parameter tvshow: Informcación del tvshow.
    func deleteFavorite(tvshow: BSTVShowsEntity)
}
protocol MATVShowDetailOutputInteractorProtocol {
    /// Proceso de almacenamieanto exitoso.
    ///  - Parameter message: Mensaje de servicio
    func storedResponseSuccess(message: String)
    /// Proceso de almacenamieanto fallido.
    ///  - Parameter message: Mensaje de servicio
    func storedResponseFailed(message: String)
    /// Agreagar entidad a favoritos exitoso.
    ///  - Parameter message: Mensaje de servicio
    func saveFavoriteSuccess(message: String)
    /// Agreagar entidad a favoritos fallido.
    ///  - Parameter message: Mensaje de servicio
    func saveFavoriteFailed(message: String)
    /// Eliminar entidad a favoritos exitoso.
    ///  - Parameter message: Mensaje de servicio
    func deleteFavoriteSuccess(message: String)
    /// Eliminar entidad a favoritos fallido.
    ///  - Parameter message: Mensaje de servicio
    func deleteFavoriteFailed(message: String)
}
