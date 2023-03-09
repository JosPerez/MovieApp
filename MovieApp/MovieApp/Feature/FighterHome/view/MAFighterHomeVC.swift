//
//  MAFighterHomeVC.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterHomeVC: BaseController {
    var presenter: MAFighterHomePresenterProtocol?
    @IBOutlet weak var fighterTableView: UITableView!
    private var isFirstLoad:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationController?.setNavBarColor(.purple)
        self.title = "Fighter List"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BSNetworkManager.shared.networkDelegate = self
        BSNetworkManager.shared.start()
    }
    func setupTableView() {
        fighterTableView.delegate = self
        fighterTableView.dataSource = self
        fighterTableView.register(UINib(nibName: "MAFighterTableCell", bundle: Bundle.main), forCellReuseIdentifier: "MAFighterTableCell")
    }

}
extension MAFighterHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MAFighterTableCell", for: indexPath) as? MAFighterTableCell else { return UITableViewCell() }
        if let data = presenter?.dataSource[indexPath.row] {
            cell.setupCell(entity: data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = self.presenter?.dataSource[indexPath.row].fighterID {
            self.presenter?.getFightersBy(id: id)
        }
    }
}
extension MAFighterHomeVC: MAFighterHomeViewProtocol {
    func reloadFighterTable() {
        fighterTableView.reloadData()
    }
}
extension MAFighterHomeVC: BSNetworkManagerDelegate {
    func didNetworkChange(status: Bool) {
        print("Internet status:",status)
        DispatchQueue.main.async {
            if self.isFirstLoad {
                self.isFirstLoad = false
                self.presenter?.getFighters()
            }
        }
    }
}
