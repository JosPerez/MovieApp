//
//  ViewController.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//
import UIKit
class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if true {
            showNetworkPlaceholder()
        }
    }
    /// Muestra el placeholder de falta de conexión
    private func showNetworkPlaceholder() {
        let networkplacehoder: UIViewController = MANetworkPlaceholderVC()
        addChild(networkplacehoder)
        networkplacehoder.view.frame = view.frame
        view.addSubview(networkplacehoder.view)
        networkplacehoder.didMove(toParent: self)
    }
    /// Remueve  el placeholder de falta de conexión
    private func removeNetworkPlaceholder() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
