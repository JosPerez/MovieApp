//
//  MAHomePresenter.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
import BackServices
final class MAHomePresenter: MAHomePresenterProtocol {
    var view: MAHomeViewProtocol?
    var router: MAHomeRouterProtocol?
    var interactor: MAHomeInputInteractorProtocol?
    var flow: MAShowFlow = .all
    func getTVShows() {
        if flow == .all {
            interactor?.getTVShows()
        } else {}
    }
}
extension MAHomePresenter: MAHomeOutputInteractorProtocol {
    func responseSuccessTVShows(list: [BSTVShowsEntity]) {
        let newList: [MATVShowDataSource] = list.map({ MATVShowDataSource(tvshow:$0) })
        view?.responseSuccessTVShows(list: newList)
    }
    func responseFailedTVShows() {}
}
