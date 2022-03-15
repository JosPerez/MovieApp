//
//  MATVShowDetailPresenter.swift
//  MovieApp
//
//  Created by jose perez on 15/03/22.
//
import Foundation
final class MATVShowDetailPresenter: MATVShowDetailPresenterProtocol {
    var view: MATVShowDetailViewProtocol?
    var router: MATVShowDetailRouterProtocol?
    var interactor: MATVShowDetailInputInteractorProtocol?
    var entity: MATVShowDataSource?
    func saveFavorite() {
        if let show = entity?.tvshowEntity {
            interactor?.saveFavorite(tvshow: show)
        }
    }
    func deleteFavorite() {
        if let show = entity?.tvshowEntity {
            interactor?.deleteFavorite(tvshow: show)
        }
    }
    func openBrowserWith(id: String) {
        router?.openBrowserWith(id: id)
    }
}
extension MATVShowDetailPresenter: MATVShowDetailOutputInteractorProtocol {
    func storedResponseSuccess(message: String) {
        if entity?.isFavorite == true {
            deleteFavoriteSuccess(message: message)
        } else {
            saveFavoriteSuccess(message: message)
        }
    }
    func storedResponseFailed(message: String) {
        if entity?.isFavorite == true {
            deleteFavoriteFailed(message: message)
        } else {
            saveFavoriteFailed(message: message)
        }
    }
    func saveFavoriteSuccess(message: String) {
        entity?.isFavorite = true
        self.view?.showMessageSucces(message: message, isFavorite: entity?.isFavorite ?? true)
    }
    func saveFavoriteFailed(message: String) {
        self.view?.showMessageFailed(message: message)
    }
    func deleteFavoriteSuccess(message: String) {
        entity?.isFavorite = false
        self.view?.showMessageSucces(message: message, isFavorite: entity?.isFavorite ?? false)
    }
    func deleteFavoriteFailed(message: String) {
        self.view?.showMessageFailed(message: message)
    }
}
