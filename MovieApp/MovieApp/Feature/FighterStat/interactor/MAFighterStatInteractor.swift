//
//  MAFighterStatInterctor.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import Foundation
import BackServices
final class MAFighterStatInteractor: MAFighterStatInputInteractorProtocol {
    var presenter: MAFighterStatOutputInteractorProtocol?
    var facade: BSFighterFacade
    public init() {
        facade = BSFighterFacade(url: "https://1e6f-187-167-248-86.ngrok.io/")
        facade.delegate = self
    }
    func getFightsBy(id: Int) {
        facade.getFighterHistorysBy(id: id)
    }
}
extension MAFighterStatInteractor: BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSFighterHistory.self):
            if let response = entity as? BSFighterHistory {
                self.presenter?.responseFightsSuccess(entity: response)
            } else if let error = entity as? BSErrorBase {
                self.presenter?.responseFightsFailed(message: error.message ?? "No se encontro")
            }
        default: break
        }
    }
}
