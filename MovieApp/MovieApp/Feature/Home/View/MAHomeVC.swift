//
//  MAHomeVC.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//

import UIKit
final class MAHomeVC: BaseController {
    var presenter: MAHomePresenterProtocol?
    var dataSource: [MATVShowDataSource] = []
    var flow: MAShowFlow = .all
    @IBOutlet private weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        presenter?.getTVShows()
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
}
extension MAHomeVC: MAHomeViewProtocol {
    func responseSuccessTVShows(list: [MATVShowDataSource]) {
        dataSource = list
        tableview.reloadData()
    }
}
