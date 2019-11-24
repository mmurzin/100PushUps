//
//  TrainingHistoryItem.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 24.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation


import Foundation
import RealmSwift

@objcMembers class TrainingHistoryItem: Object {

     dynamic var timeMs: Int64 = 0
     dynamic var trainingStage: Int = 0
     dynamic var trainingPosition: Int = 0
     dynamic var progress: String = ""

     override class func primaryKey() -> String? {
          return "timeMs"
     }
}
