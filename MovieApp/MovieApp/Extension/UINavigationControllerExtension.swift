//
//  UINavigationControllerExtension.swift
//  MovieApp
//
//  Created by jose perez on 14/03/22.
//
import UIKit
extension UINavigationController {
    func setNavBarColor(_ color: UIColor) {
        navigationBar.barStyle = .black
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
