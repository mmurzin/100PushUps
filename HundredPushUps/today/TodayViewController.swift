//
//  TodayViewController.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 21.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let asset = NSDataAsset(name: "GroupsJson") else {
            fatalError("Missing data asset: GroupsJson")
        }

        let data = asset.data
        print(data)
        
    }
}
