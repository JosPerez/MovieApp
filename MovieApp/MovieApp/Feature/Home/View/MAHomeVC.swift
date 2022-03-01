//
//  MAHomeVC.swift
//  MovieApp
//
//  Created by jose perez on 28/02/22.
//

import UIKit
final class MAHomeVC: BaseController {
    var presenter: MAHomePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension MAHomeVC: MAHomeViewProtocol {}
