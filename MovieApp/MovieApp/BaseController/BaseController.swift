//
//  ViewController.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import UIKit
import BackServices
class BaseController: UIViewController {
    /// Placeholder de  conectividad
    let networkplacehoder: UIViewController = MANetworkPlaceholderVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        BSNetworkManager.shared.networkDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //BSNetworkManager.shared.start()
        //networkStatusPlaceholder(status: BSNetworkManager.shared.networkStatus())
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //BSNetworkManager.shared.cancel()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
/// Extensión con la información de red
extension BaseController: BSNetworkManagerDelegate {
    /// Muestra el placeholder de falta de conexión
    private func showNetworkPlaceholder() {
        addChild(networkplacehoder)
        networkplacehoder.view.frame = view.frame
        view.addSubview(networkplacehoder.view)
        networkplacehoder.didMove(toParent: self)
    }
    /// Remueve  el placeholder de falta de conexión
    private func removeNetworkPlaceholder() {
        willMove(toParent: nil)
        networkplacehoder.view.removeFromSuperview()
        networkplacehoder.removeFromParent()
    }
    /// Muestra u ocualta el placeholder  de conectividad
    private func networkStatusPlaceholder(status: Bool) {
        DispatchQueue.main.async {
            !status ? self.showNetworkPlaceholder() : self.removeNetworkPlaceholder()
        }
    }
    func didNetworkChange(status: Bool) {
        networkStatusPlaceholder(status: status)
    }
}
