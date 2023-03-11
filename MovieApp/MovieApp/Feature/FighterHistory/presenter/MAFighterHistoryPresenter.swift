import Foundation
import BackServices
final class MAFighterHistoryPresenter: MAFighterHistoryPresenterProtocol {
    var view: MAFighterHistoryViewProtocol?
    var interactor: MAFighterHistoryInputInteractorProtocol?
    var router: MAFighterHistoryRouterProtocol?
    var history: BSFighterHistory?
}
extension MAFighterHistoryPresenter: MAFighterHistoryOutputInteractorProtocol {}
