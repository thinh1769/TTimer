//
//  TabBarViewController.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 18/02/2024.
//

import UIKit
import Combine

class TabBarViewController: UITabBarController {

    let timerTab = TimerViewController()
    let timeListTab = TimeListViewController()
    var cancellableSet: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let timerNaVC = UINavigationController(rootViewController: timerTab)
        
        let timeListNaVC = UINavigationController(rootViewController: timeListTab)
        
        timerTab.tabBarItem.image = UIImage(systemName: "timer")
        timeListTab.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        
        let tabBarItemList = [timerNaVC,timeListNaVC]
        
        self.setViewControllers(tabBarItemList, animated: true)
        
        self.tabBar.tintColor = .systemBlue
        
        self.tabBar.backgroundColor = .black
        
        setupSubcriptions()
    }
    
    private func setupSubcriptions() {
        cancellableSet = []
        
        timerTab.$time
            .receive(on: DispatchQueue.main)
            .sink { [weak self] time in
                guard let self else { return }
                self.timeListTab.time = time
            }
            .store(in: &cancellableSet)
    }
}
