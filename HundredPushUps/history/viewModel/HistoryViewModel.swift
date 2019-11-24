//
//  HistoryViewModel.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 24.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RealmSwift

class HistoryViewModel {
    
    private let formatter = DateFormatter()
    
    private let realm = try! Realm()
    
    init() {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func loadTrainingsHistory() -> [TrainingHistoryItem] {
        let historyItems = try! Realm().objects(TrainingHistoryItem.self)
        return historyItems.sorted{ $0.timeMs > $1.timeMs}
    }
    
    func formatDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }
}
