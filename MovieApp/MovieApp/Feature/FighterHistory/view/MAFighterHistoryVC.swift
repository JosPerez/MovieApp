import UIKit
final class MAFighterHistoryVC: BaseController {
    @IBOutlet private weak var historyTable: UITableView!
    var presenter: MAFighterHistoryPresenterProtocol?
    var fighterName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fighterName
        setupTable()
    }
    func setupTable() {
        self.historyTable.delegate = self
        self.historyTable.dataSource = self
        self.historyTable.register(UINib(nibName: "MAFighterFightCell", bundle: Bundle.main), forCellReuseIdentifier: "MAFighterFightCell")
        self.historyTable.reloadData()
    }
}
extension MAFighterHistoryVC: MAFighterHistoryViewProtocol {}
extension MAFighterHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.history?.fights?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let entity = self.presenter?.history?.fights {
            if let cell = self.historyTable.dequeueReusableCell(withIdentifier: "MAFighterFightCell", for: indexPath) as? MAFighterFightCell {
                cell.setup(entity: entity[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}
