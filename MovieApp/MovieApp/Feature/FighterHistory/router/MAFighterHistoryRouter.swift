import BackServices
final class MAFighterHistoryRouter: MAFighterHistoryRouterProtocol {
    var presenter: MAFighterHistoryPresenterProtocol?
    var view: MAFighterHistoryVC?
    static func createView(fighterName: String, entity: BSFighterHistory) -> UIViewController {
        let view = MAFighterHistoryVC()
        let presenter = MAFighterHistoryPresenter()
        let router = MAFighterHistoryRouter()
        view.presenter = presenter
        view.fighterName = fighterName
        presenter.view = view
        presenter.router = router
        presenter.history = entity
        router.view = view
        router.presenter = presenter
        return view
    }
}
