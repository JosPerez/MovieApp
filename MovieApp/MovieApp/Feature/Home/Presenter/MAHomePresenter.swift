//
//  MAHomePresenter.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
final class MAHomePresenter: MAHomePresenterProtocol {
    var view: MAHomeViewProtocol?
    var router: MAHomeRouterProtocol?
    var interactor: MAHomeInputInteractorProtocol?
}
extension MAHomePresenter: MAHomeOutputInteractorProtocol {}
