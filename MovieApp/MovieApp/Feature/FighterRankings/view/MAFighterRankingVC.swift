//
//  MAFighterRankingsVC.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterRankingsVC: BaseController {
    @IBOutlet private weak var rankingTableView: UITableView!
    var presenter: MAFighterRankingPresenterProtocol?
    var headerData: [HeaderData] = []
    private var isFirstLoad: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        BSNetworkManager.shared.networkDelegate = self
        setupTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Rankings"
        BSNetworkManager.shared.start()
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BSNetworkManager.shared.cancel()
    }
    func setupTable() {
        self.rankingTableView.delegate = self
        self.rankingTableView.dataSource = self
        self.rankingTableView.register(UINib(nibName: "MARankCell", bundle: nil), forCellReuseIdentifier: "MARankCell")
        self.rankingTableView.tableHeaderView = UIView()
        self.rankingTableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.rankingTableView.sectionHeaderTopPadding = 8
        }
    }
}
extension MAFighterRankingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerData[section].isExpanded ? headerData[section].details.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = rankingTableView.dequeueReusableCell(withIdentifier: "MARankCell", for: indexPath) as? MARankCell {
            let data = headerData[indexPath.section].details[indexPath.row]
            cell.setupCell(entity: data)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fighter = headerData[indexPath.section].details[indexPath.row]
        self.presenter?.getFightersBy(name: fighter.name,id: fighter.fighterID)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = headerData[section].title.replacingOccurrences(of: " ", with: "\n")
        let image = headerData[section].imgUrl
        let headerView = MACustomHeaderView(title: title, image: image)
        headerView.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section
        return headerView
    }
    @objc func headerTapped(_ gesture: UITapGestureRecognizer) {
        if let section = gesture.view?.tag {
            let isExpanded = headerData[section].isExpanded
            headerData[section].isExpanded = !isExpanded
            if !isExpanded {
                rankingTableView.reloadSections(IndexSet(integer: section), with: .bottom)
                if headerData[section].details.count > 0 {
                    rankingTableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: false)
                }
            } else {
                var paths: [IndexPath] = []
                for i in 0..<headerData[section].details.count {
                    let path = IndexPath(item: i, section: section)
                    paths.append(path)
                }
                let currentOffSet = rankingTableView.contentOffset
                print("Current Offset: \(currentOffSet)")
                rankingTableView.deleteRows(at: paths, with: .none)
                rankingTableView.layoutIfNeeded()
                if currentOffSet.y < 489.0 {
                    rankingTableView.setContentOffset(currentOffSet, animated: false)
                } else if currentOffSet.y < 619, section < 7 {
                    rankingTableView.setContentOffset(CGPoint(x: currentOffSet.x, y: 583), animated: false)
                } else {
                    rankingTableView.setContentOffset(CGPoint(x: currentOffSet.x, y: 681), animated: false)
                }
                
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88.0
    }
}
extension MAFighterRankingsVC: MAFighterRankingViewProtocol {
    func setupHeaderData(entity: [HeaderData]) {
        self.headerData = entity
        self.rankingTableView.reloadData()
    }
}
extension MAFighterRankingsVC: BSNetworkManagerDelegate {
    func didNetworkChange(status: Bool) {
        print("Internet status:",status)
        if isFirstLoad{
            isFirstLoad = false
            self.presenter?.getRankings()
        }
    }
}
