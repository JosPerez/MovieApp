//
//  MAHomePresenter.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
import BackServices
final class MAHomePresenter: MAHomePresenterProtocol {
    var dataSource: [BSTVShowsEntity]?
    var view: MAHomeViewProtocol?
    var router: MAHomeRouterProtocol?
    var interactor: MAHomeInputInteractorProtocol?
    var flow: MAShowFlow = .all
    func getTVShows() {
        interactor?.getTVShows()
    }
    func getFavoriteTVShows() {
        interactor?.getFavoriteTVShows()
    }
    func saveFavorite(tvshow: BSTVShowsEntity) {
        interactor?.saveFavorite(tvshow: tvshow)
    }
    func deleteFavorite(tvshow: BSTVShowsEntity) {
        interactor?.deleteFavorite(tvshow: tvshow)
    }
}
extension MAHomePresenter: MAHomeOutputInteractorProtocol {
    func responseSuccessTVShows(list: [BSTVShowsEntity]) {
        dataSource = list
        interactor?.getFavoriteTVShows()
    }
    func responseSuccessFavoriteTVShows(list: [BSTVShowsEntity]) {
        switch flow {
        case .all:
            setAllFavoriteShows(list: list)
        case .favorite:
            showFavoriteShow(list: list)
        }
    }
    /// Muestra información a lista de favoritos
    /// - Parameter list: Lista de programas
    private func showFavoriteShow(list: [BSTVShowsEntity]) {
        if list.isEmpty {
            view?.responseSuccessFavoriteTVShows(list: [])
        } else {
            let newList: [MATVShowDataSource] = list.compactMap({ MATVShowDataSource(tvshow: $0, isFavorite: true) })
            view?.responseSuccessFavoriteTVShows(list: newList)
        }

    }
    /// Asigna información a lista de favoritos
    /// - Parameter list: Lista de programas
    private func setAllFavoriteShows(list: [BSTVShowsEntity]) {
        if let entity = dataSource, !entity.isEmpty {
            let newList: [MATVShowDataSource] = entity.compactMap({ MATVShowDataSource(tvshow: $0) })
            if !list.isEmpty {
                for item in newList {
                    item.isFavorite = list.contains(where: { $0.id == item.tvshowEntity.id })
                }
            }
            view?.responseSuccessTVShows(list: newList)
        }
    }
    func responseFailedTVShows(message: String?) {
        guard let message = message else {
            view?.responseFailedTVShows(message: "Error Generico.")
            return
        }
        view?.responseFailedTVShows(message: message)
    }
    func storedResponseFailed(message: String?) {
        view?.showMessage(message: message ?? "Errror Generico.", isError: true)
    }
    func storedResponseSuccess(message: String?) {
        view?.showMessage(message: message ?? "Success Generico", isError: false)
    }
}
