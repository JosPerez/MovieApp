//
//  MAHomeInteractor.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
import BackServices
final class MAHomeInteractor: MAHomeInputInteractorProtocol {
    var presenter: MAHomeOutputInteractorProtocol?
    func getTVShows() {
        let facade: BSTVShowsFacade = BSTVShowsFacade(url: "http://api.tvmaze.com/")
        facade.delegate = self
        facade.getTVShows()
    }
    func getFavoriteTVShows() {
        let facade: BSTVShowsFacade = BSTVShowsFacade(url: "")
        facade.delegate = self
        facade.getFavoriteShow()
    }
    func saveFavorite(tvshow: BSTVShowsEntity) {
        let facade: BSTVShowsFacade = BSTVShowsFacade(url: "")
        facade.delegate = self
        facade.saveFavorite(tvshow: tvshow)
    }
    func deleteFavorite(tvshow: BSTVShowsEntity) {
        let facade: BSTVShowsFacade = BSTVShowsFacade(url: "")
        facade.delegate = self
        facade.deleteFavorite(tvshow: tvshow)
    }
}
extension MAHomeInteractor: BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSTVShowsEntity.self):
            if let response = entity as? [BSTVShowsEntity] {
                presenter?.responseSuccessTVShows(list: response)
                print(response)
            } else if let error = entity as? BSErrorBase {
                print(error)
                presenter?.responseFailedTVShows(message: error.message)
            }
        case String(describing: [BSTVShowsEntity].self):
            if let response = entity as? [BSTVShowsEntity] {
                presenter?.responseSuccessFavoriteTVShows(list: response)
                print(response)
            } else if let error = entity as? BSErrorBase {
                print(error)
                presenter?.responseFailedTVShows(message: error.message)
            }
        case String(describing: BSSaveFavoriteResponse.self):
            if let response = entity as? BSSaveFavoriteResponse {
                if let isError = response.isError, !isError {
                    presenter?.storedResponseSuccess(message: response.message)
                } else {
                    presenter?.storedResponseFailed(message: response.message)
                }
            }
        default: break
        }
    }
}
