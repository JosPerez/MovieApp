//
//  MAFighterHomeVC.swift
//  MovieApp
//
//  Created by jose perez on 08/03/23.
//
import UIKit
import BackServices
final class MAFighterHomeVC: BaseController {
    @IBOutlet weak var segmentGender: UISegmentedControl!
    private var searchBar: UISearchBar?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    @IBOutlet private weak var fighterTableView: UITableView!
    var presenter: MAFighterHomePresenterProtocol?
    private var isFirstLoad:Bool = true
    private var currentSource: [BSFighterEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSegementControl()
        BSNetworkManager.shared.networkDelegate = self
        self.navigationController?.setNavBarColor(.purple)
        self.title = "Fighter List"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BSNetworkManager.shared.start()
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BSNetworkManager.shared.cancel()
    }
    func setupTableView() {
        fighterTableView.delegate = self
        fighterTableView.dataSource = self
        fighterTableView.register(UINib(nibName: "MAFighterTableCell", bundle: Bundle.main), forCellReuseIdentifier: "MAFighterTableCell")
        fighterTableView.separatorStyle = .none
        /// Create searchBar
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.fighterTableView.bounds.width, height: 48))
        searchBar?.placeholder = "Search Fighter"
        searchBar?.sizeToFit()
        searchBar?.delegate = self
        searchBar?.showsCancelButton = true
        searchBar?.enablesReturnKeyAutomatically = false
        searchBar?.autocapitalizationType = .words
        /// Se agrega a la vista header
        fighterTableView.tableHeaderView = searchBar
        /// Se inicializa el refrsh control
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        fighterTableView.addSubview(refreshControl)
    }
    func setupSegementControl() {
        /// Segment Control general change
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        /// Segement Control local change
        segmentGender.selectedSegmentTintColor = .purple
    }
    @objc func refreshTable() {
        if segmentGender.selectedSegmentIndex == 0 {
            presenter?.getFighters()
        } else {
            refreshControl.endRefreshing()
        }
    }
}
extension MAFighterHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = fighterTableView.dequeueReusableCell(withIdentifier: "MAFighterTableCell", for: indexPath) as? MAFighterTableCell else { return UITableViewCell() }
        let data = currentSource[indexPath.row]
        cell.setupCell(entity: data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.currentSource[indexPath.row].fighterID
        self.presenter?.getFightersBy(id: id)
    }
}
// MARK: - Search Bar Delegate
extension MAFighterHomeVC: UISearchBarDelegate {
    fileprivate func searchBarSearch(_ searchText: String) {
        let names = searchText.split(separator: " ")
        if !names.isEmpty {
            self.currentSource = self.currentSource.filter({ entity in
                var isLikeLast = false
                if let lastName = entity.lastName {
                    if names.count > 0 {
                        isLikeLast = lastName.uppercased().contains(names[0].uppercased())
                    }
                    if names.count > 1 {
                        let isLikeFirst = entity.firstName.uppercased().contains(names[1].uppercased())
                        return isLikeLast && isLikeFirst
                    }
                    
                }
                return  isLikeLast
            })
        }
        fighterTableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text != "\n" {
            assignCurrentGender(segmentGender.selectedSegmentIndex)
            var searchText = searchBar.text ?? ""
            if range.length == 1 {
                searchText.removeLast()
            } else {
                searchText = searchText + text
            }
            searchBarSearch(searchText)
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        assignCurrentGender(segmentGender.selectedSegmentIndex)
        fighterTableView.reloadData()
    }
}
// MARK: - Segment Control Actions
extension MAFighterHomeVC {
    fileprivate func assignCurrentGender(_ index: Int) {
        switch index {
        case 0:
            if let entity = self.presenter?.dataSource {
                self.currentSource = entity
            }
        case 1:
            if let entity = self.presenter?.dataSource {
                self.currentSource = entity
                self.currentSource = self.currentSource.filter({ $0.weightClass?.contains("Women") == false })
            }
        case 2:
            if let entity = self.presenter?.dataSource {
                self.currentSource = entity
                self.currentSource = self.currentSource.filter({ $0.weightClass?.contains("Women") == true })
            }
        default: break
        }
    }
    
    @IBAction func segmentChage(_ sender: UISegmentedControl) {
        self.searchBar?.resignFirstResponder()
        self.searchBar?.text = ""
        assignCurrentGender(sender.selectedSegmentIndex)
        fighterTableView.reloadData()
    }
}
extension MAFighterHomeVC: MAFighterHomeViewProtocol {
    func reloadFighterTable() {
        if let entity = self.presenter?.dataSource {
            self.currentSource = entity
        }
        fighterTableView.reloadData()
        refreshControl.endRefreshing()
    }
    func fighterServiceFailed() {
        refreshControl.endRefreshing()
    }
}
extension MAFighterHomeVC: BSNetworkManagerDelegate {
    func didNetworkChange(status: Bool) {
        print("Internet status:",status)
        DispatchQueue.main.async {
            if self.isFirstLoad && status {
                self.isFirstLoad = false
                self.presenter?.getFighters()
            }
        }
    }
}
