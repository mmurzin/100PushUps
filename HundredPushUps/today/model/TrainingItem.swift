//
//  File.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

class TrainingItem: Decodable {
        var id: Int
        var setsPause: Int
        var daysPause: Int
        var sets: [Int]
        
        enum Keys: String, CodingKey {
            case id
            case setsPause = "sets_pause"
            case daysPause = "days_pause"
            case sets
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            id = try container.decode(Int.self, forKey: .id)
            setsPause = try container.decode(Int.self, forKey: .setsPause)
            daysPause = try container.decode(Int.self, forKey: .daysPause)
            sets = try container.decode([Int].self, forKey: .sets)
        }
}

