//
//  MAFighterStatVC.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterStatVC: BaseController {
    var presenter: MAFighterStatPresenterProtocol?
    var fighterName: String?
    @IBOutlet weak var fighterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        BSNetworkManager.shared.networkDelegate = self
        self.title = self.fighterName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BSNetworkManager.shared.start()
        self.presenter?.setupDataSource()
    }
    func setupTableView() {
        self.fighterTableView.delegate = self
        self.fighterTableView.dataSource = self
        self.fighterTableView.separatorStyle = .none
        self.fighterTableView.register(UINib(nibName: "MAStatCircularCell", bundle: Bundle.main), forCellReuseIdentifier: "MAStatCircularCell")
        self.fighterTableView.register(UINib(nibName: "MARecordCell", bundle: Bundle.main), forCellReuseIdentifier: "MARecordCell")

    }

}
extension MAFighterStatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.dataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 80 : 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let current = self.presenter?.dataSource?[indexPath.row] {
            switch current.type {
            case .record(let record):
                if  let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MARecordCell", for: indexPath) as? MARecordCell {
                    cell.setupCell(record: record)
                    return cell
                }
            case .circularGraph(let landed, let throwed, let type):
                if  let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MAStatCircularCell", for: indexPath) as? MAStatCircularCell {
                    cell.setupCell(landed: landed, throwed: throwed, type: type)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}
extension MAFighterStatVC: MAFighterStatViewProtocol {
    func setupDataSourceSuccess() {
        self.fighterTableView.reloadData()
    }
}
extension MAFighterStatVC: BSNetworkManagerDelegate {
    func didNetworkChange(status: Bool) {
        print("Internet status:",status)
    }
}
