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
}
extension MAHomeInteractor: BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSTVShowsEntity.self):
            if let response = entity as? [BSTVShowsEntity] {
                presenter?.responseSuccessTVShows(list: response)
                print(response)
            } else {
                presenter?.responseFailedTVShows()
            }
        default: break
        }
    }
}
