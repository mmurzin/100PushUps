//
//  TrainingProgress.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class TrainingProgress: Object {

     static let uniqueKey: String = "TrainingProgress"

     dynamic var uniqueKey: String = TrainingProgress.uniqueKey
     dynamic var currentIndex: Int = 0
     dynamic var lastIndex: Int = 0
     dynamic var startTs: Int64 = 0

     override class func primaryKey() -> String? {
          return "uniqueKey"
     }
}
