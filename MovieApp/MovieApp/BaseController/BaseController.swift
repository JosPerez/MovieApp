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
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /// Muestra Toast con mensaje y color necesario
    ///  - Parameters:
    ///  - message: Mensajes a mostrar.
    ///  - font: Tamaño de fuente
    ///  - isError: Color para cuando es error.
    func showToast(message : String, font: UIFont, isError: Bool = false) {
        let toastLabel = UILabel(frame: CGRect(x: 16, y: self.view.frame.size.height-150, width: self.view.frame.size.width-32, height: 40))
        toastLabel.backgroundColor = isError ? .red : .green
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .transitionCurlUp, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    /// Configura la alerta para elimianar  el favorito.
    ///  - Parameters
    ///  - description: Descripción de la alerta
    ///  - complation: Acción para complementar.
    func showMainAlert(description: String, complation: (() -> Void)?) {
        let alert = UIAlertController(title: "Oops, something went wrong", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: ({_ in
            complation?()
        })))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
/// Extensión con la información de red
extension BaseController {
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
    func networkStatusPlaceholder(status: Bool) {
        status ? self.showNetworkPlaceholder() : self.removeNetworkPlaceholder()
    }
}
