//
//  TestResult.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 22.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class TestResult: Object {

     static let uniqueKey: String = "TestResult"

     dynamic var uniqueKey: String = TestResult.uniqueKey
     dynamic var pushUpsCount: Int = 0

     override class func primaryKey() -> String? {
          return "uniqueKey"
     }
}
