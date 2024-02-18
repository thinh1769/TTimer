//
//  TabBarViewController.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 18/02/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let timerTab = TimerViewController()
        let timerNaVC = UINavigationController(rootViewController: timerTab)
        
        let timeListTab = TimeListViewController()
        let timeListNaVC = UINavigationController(rootViewController: timeListTab)
        
        timerTab.tabBarItem.image = UIImage(systemName: "timer")
        timeListTab.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        
        let tabBarItemList = [timerNaVC,timeListNaVC]
        
        self.setViewControllers(tabBarItemList, animated: true)
        
        self.tabBar.tintColor = .systemBlue
        
        self.tabBar.backgroundColor = .black
    }
}
