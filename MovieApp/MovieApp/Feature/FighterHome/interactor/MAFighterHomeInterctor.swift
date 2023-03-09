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
        facade = BSFighterFacade(url: "http://127.0.0.1:5000/")
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
                print(error)
            }
        case String(describing: BSFighterStatEntity.self):
            if let response = entity as? BSFighterStatEntity {
                self.presenter?.responseFightersStatsSuccess(entity: response)
            } else if let error = entity as? BSErrorBase {
                self.presenter?.responseFightersStatsError(message: "No Encontrado")
            }
        default: break
        }
    }
}
