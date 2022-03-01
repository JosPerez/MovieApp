//
//  MASplashScreen.swift
//  MovieApp
//
//  Created by jose perez on 01/03/22.
//
import UIKit
final class MASplashScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {})
    }
}
