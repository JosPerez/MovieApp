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
    var firstLoad:Bool = true
    @IBOutlet weak var fighterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        BSNetworkManager.shared.networkDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.fighterName
        BSNetworkManager.shared.start()
        self.presenter?.setupDataSource()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
        BSNetworkManager.shared.cancel()
    }
    func setupTableView() {
        self.fighterTableView.delegate = self
        self.fighterTableView.dataSource = self
        self.fighterTableView.separatorStyle = .none
        self.fighterTableView.register(UINib(nibName: "MAStatCircularCell", bundle: Bundle.main), forCellReuseIdentifier: "MAStatCircularCell")
        self.fighterTableView.register(UINib(nibName: "MARecordCell", bundle: Bundle.main), forCellReuseIdentifier: "MARecordCell")
        self.fighterTableView.register(UINib(nibName: "MAThreeStatGraphCell", bundle: Bundle.main), forCellReuseIdentifier: "MAThreeStatGraphCell")
    }

}
extension MAFighterStatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.dataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let entity = self.presenter?.dataSource?[indexPath.row].type {
            switch entity {
            case .circularGraph:
                return 220.0
            case .ThreeStatGraph:
                return 164.0
            default:
                return 160.0
            }
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let current = self.presenter?.dataSource?[indexPath.row] {
            switch current.type {
            case .record(let record, let avgFight):
                if  let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MARecordCell", for: indexPath) as? MARecordCell {
                    cell.setupCell(record: record, avgFightTime: avgFight)
                    return cell
                }
            case .circularGraph(let landed, let throwed, let type):
                if  let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MAStatCircularCell", for: indexPath) as? MAStatCircularCell {
                    cell.setupCell(landed: landed, throwed: throwed, type: type)
                    return cell
                }
            case .ThreeStatGraph(let entity):
                if  let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MAThreeStatGraphCell", for: indexPath) as? MAThreeStatGraphCell {
                    cell.setupCell(entity: entity)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}
extension MAFighterStatVC: MAFighterStatViewProtocol {    
    @objc func showFightsObj() {
        self.presenter?.showFights()
    }
    func setupDataSourceSuccess() {
        self.fighterTableView.reloadData()
    }
    func responseFightsSuccess() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showFightsObj))
        navigationItem.rightBarButtonItem = barButton
    }
}
extension MAFighterStatVC: BSNetworkManagerDelegate {
    func didNetworkChange(status: Bool) {
        print("Internet status:",status)
        if firstLoad, let id = self.presenter?.entity?.fighterId {
            firstLoad = false
            self.presenter?.getFightsBy(id: id)
        }
    }
}
