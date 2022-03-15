//
//  MATVShowDetailInteractor.swift
//  MovieApp
//
//  Created by jose perez on 15/03/22.
//
import Foundation
import BackServices
final class MATVShowDetailInteractor: MATVShowDetailInputInteractorProtocol {
    var presenter: MATVShowDetailOutputInteractorProtocol?
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
extension MATVShowDetailInteractor: BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSSaveFavoriteResponse.self):
            if let response = entity as? BSSaveFavoriteResponse {
                if let isError = response.isError, !isError {
                    presenter?.storedResponseSuccess(message: response.message ?? "Exitoso.")
                } else {
                    presenter?.storedResponseFailed(message: response.message ?? "Error Generico")
                }
            }
        default: break
        }
    }
}
