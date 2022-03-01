//
//  MAHomeProtocol.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import Foundation
protocol MAHomeViewProtocol {
    var presenter: MAHomePresenterProtocol? { get }
}
protocol MAHomePresenterProtocol {
    var view: MAHomeViewProtocol? { get }
    var router: MAHomeRouterProtocol? { get }
    var interactor: MAHomeInputInteractorProtocol? { get }
}
protocol MAHomeRouterProtocol {}
protocol MAHomeInputInteractorProtocol {
    var presenter: MAHomeOutputInteractorProtocol? { get }
}
protocol MAHomeOutputInteractorProtocol {}
