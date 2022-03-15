//
//  MAHomeVC.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//

import UIKit
import BackServices
final class MAHomeVC: BaseController {
    var presenter: MAHomePresenterProtocol?
    var dataSource: [MATVShowDataSource] = []
    var flow: MAShowFlow = .all
    @IBOutlet private weak var tableview: UITableView!
    @IBOutlet private weak var favoritePlaceholder: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if flow == .all {
            BSNetworkManager.shared.networkDelegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        if flow == .all {
            BSNetworkManager.shared.start()
        } else {
            presenter?.getFavoriteTVShows()
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if flow == .all {
            BSNetworkManager.shared.cancel()
        }
    }
    ///  Clase que asigna valoresa vista
    private func setupView() {
        self.navigationController?.setNavBarColor(.init(red: 102/255, green: 31/255, blue: 255/255, alpha: 1))
        self.title = flow.rawValue
    }
    /// Clase  que asignas configuración inicial a tableview
    private func setupTableView() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "MATVShowCell", bundle: Bundle.main), forCellReuseIdentifier: "MATVShowCell")
        tableview.reloadData()
    }
}
extension MAHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "MATVShowCell", for: indexPath) as? MATVShowCell else { return UITableViewCell() }
        let data = dataSource[indexPath.row]
        cell.setupCell(entity: data)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = dataSource[indexPath.row].isFavorite ? deleteFavorite(row: indexPath.row) : addFavorite(row: indexPath.row)
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.showShowDetail(entity: dataSource[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    /// Configura la acción para guardar el favorito.
    ///  - Parameter row: Fila seleccioanda
    ///  - Returns: Acción configurada.
    private func addFavorite(row: Int) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favorite") { action, view, completion in
            self.dataSource[row].isFavorite = true
            self.presenter?.saveFavorite(tvshow: self.dataSource[row].tvshowEntity)
            completion(true)
        }
        action.backgroundColor = .green
        return action
    }
    /// Configura la acción para guardar el favorito.
    ///  - Parameter row: Fila seleccioanda
    ///  - Returns: Acción configurada.
    private func deleteFavorite(row: Int) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            self.showDeleteAlert(row: row)
            completion(true)
        }
        action.backgroundColor = .red
        return action
    }
    /// Configura la alerta para elimianar  el favorito.
    ///  - Parameter row: Fila seleccioanda
    private func showDeleteAlert(row: Int) {
        let alert = UIAlertController(title: "Delete Favorite", message: "Do you want to continue?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DELETE", style: .destructive, handler: { action in
            self.dataSource[row].isFavorite = false
            self.presenter?.deleteFavorite(tvshow: self.dataSource[row].tvshowEntity)
            if self.flow == .favorite {
                let id = self.dataSource[row].tvshowEntity.id
                self.dataSource.removeAll(where: {$0.tvshowEntity.id == id})
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension MAHomeVC: MAHomeViewProtocol {
    func responseSuccessTVShows(list: [MATVShowDataSource]) {
        if !list.isEmpty {
            dataSource = list
            tableview.reloadData()
        }
    }
    func responseSuccessFavoriteTVShows(list: [MATVShowDataSource]) {
        if list.isEmpty {
            self.favoritePlaceholder.isHidden = false
        } else {
            self.favoritePlaceholder.isHidden = true
            dataSource = list
            tableview.reloadData()
        }
    }
    func responseFailedTVShows(message: String) {
        self.showMainAlert(description: "An error occurred while fetching data. Do you want to try again?", complation: self.presenter?.getTVShows)
    }
    func showMessage(message: String, isError: Bool) {
        self.showToast(message: message, font: UIFont.systemFont(ofSize: 16.0), isError: isError)
        DispatchQueue.main.async {
            if !isError {
                if self.dataSource.isEmpty && self.flow == .favorite {
                    self.favoritePlaceholder.isHidden = false
                } else {
                    self.favoritePlaceholder.isHidden = true
                    self.tableview.reloadData()
                }
            }
        }
    }
}
extension MAHomeVC: BSNetworkManagerDelegate {
    func didNetworkChange(status: Bool) {
        print(status)
        if flow == .all {
            DispatchQueue.main.async {
                if status {
                    if self.dataSource.isEmpty {
                        self.presenter?.getTVShows()
                    }
                    self.networkStatusPlaceholder(status: false)
                } else {
                    self.networkStatusPlaceholder(status: true)
                }
            }
        }
    }
}
