//
//  MAFighterHomeInterctor.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
// 
import Foundation
import BackServices
final class MAFighterHomeInteractor: MAFighterHomeInputInteractorProtocol {
    var presenter: MAFighterHomeOutputInteractorProtocol?
    var facade : BSFighterFacade
    public init() {
        facade = BSFighterFacade(url: "https://1e6f-187-167-248-86.ngrok.io/")
        facade.delegate = self
    }    
    func getFighters() {
        facade.getFighterProfile()
    }
    func getFightersBy(id: Int) {
        facade.getFighterStatsBy(id: id)
    }
}
extension MAFighterHomeInteractor: BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSFighterEntity.self):
            if let response = entity as? [BSFighterEntity] {
                self.presenter?.responseFightersSuccess(entity: response)
            } else if let error = entity as? BSErrorBase {
                self.presenter?.responseFightersStatsError(message:  error.message ?? "No encontrados")
            }
        case String(describing: BSFighterStatEntity.self):
            if let response = entity as? BSFighterStatEntity {
                self.presenter?.responseFightersStatsSuccess(entity: response)
            } else if let error = entity as? BSErrorBase {
                self.presenter?.responseFightersStatsError(message: error.message ?? "No Encontrado")
            }
        default: break
        }
    }
}
