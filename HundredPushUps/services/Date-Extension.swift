//
//  Date-Extension.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation


extension Date {
    var milliseconds:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
