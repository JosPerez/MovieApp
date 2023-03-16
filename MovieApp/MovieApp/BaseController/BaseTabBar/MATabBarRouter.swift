//
//  MATabBarRouter.swift
//  MovieApp
//
//  Created by jose perez on 14/03/22.
//
import Foundation
import UIKit
final public class MATabBarRouter: NSObject {
    static var imgItems: [UIImage?] = [UIImage(systemName: "figure.martial.arts"), UIImage(systemName: "chart.bar.fill")]
    static func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        /// Se configura view controller de home
        let home = MAHomeRouter(flow: .all)
        let navHome = UINavigationController(rootViewController: home.view)
        /// Se configura view controller de favorite
        let favorite = MAHomeRouter(flow: .favorite)
        favorite.view.title = MAShowFlow.favorite.rawValue
        let navFavorite = UINavigationController(rootViewController: favorite.view)
        tabBar.setViewControllers([navHome, navFavorite], animated: false)
        guard let items = tabBar.tabBar.items else {
            return tabBar
        }
        for (index, item) in items.enumerated() {
            item.image = imgItems[index]
        }
        return tabBar
    }
    static func createFighterTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        /// Se configura view controller de home
        let home = MAFighterHomeRouter.createView()
        let navHome = UINavigationController(rootViewController: home)
        /// Se configura view controller de favorite
        let favorite = MAFighterRankingRouter.createView()
        favorite.title = "Rankings"
        let navFavorite = UINavigationController(rootViewController: favorite)
        navFavorite.setNavBarColor(.purple)
        tabBar.setViewControllers([navHome, navFavorite], animated: false)
        guard let items = tabBar.tabBar.items else {
            return tabBar
        }
        for (index, item) in items.enumerated() {
            item.image = imgItems[index]
        }
        return tabBar
    }
}
