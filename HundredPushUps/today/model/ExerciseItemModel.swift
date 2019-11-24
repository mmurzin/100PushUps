//
//  ExerciseItemModel.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

class ExerciseItemModel {
    var isCompleted:Bool = false
    let pushUpsCount: Int
    
    init(pushUpsCount: Int) {
        self.pushUpsCount = pushUpsCount
    }
    
}
