//
//  TabsViewController.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 22.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "История" {
            let viewController = viewControllers?[1]
            if  viewController is HistoryViewController {
                (viewController as! HistoryViewController).loadTrainingsHistory()
            }
        }
    }
    


}
