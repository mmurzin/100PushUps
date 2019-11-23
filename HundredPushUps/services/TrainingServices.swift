//
//  TrainingServices.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TrainingServices {
    
    private let jsonData: TrainingsJson
    private let realm = try! Realm()
    private let maxTrainingIndex: Int
    typealias Progress = (currentIndex: Int, lastIndex: Int, startTs: Int64)
    
    init() {
        guard let asset = NSDataAsset(name: "Trainings") else {
            fatalError("Missing data asset: Trainings")
        }

        let data = asset.data
        let decoder = JSONDecoder()
        jsonData = try! decoder.decode(TrainingsJson.self, from: data)
        self.maxTrainingIndex = jsonData.items.max { $0.id < $1.id }!.id
    }
    
    func setInitPushUps(_ pushUpsCount: Int) {
        let minPauseAfterTest = 2
        
        let initTrainingData = getTrainingData(byPushUpsCount: pushUpsCount)
        
        let initTrainingIndex = initTrainingData.0
        var endTrainingIndex = getTrainingData(byPushUpsCount: initTrainingData.1 + 1).0
        if(endTrainingIndex != maxTrainingIndex) {
            endTrainingIndex = endTrainingIndex - 1
        }
        
        let dayToStart = Calendar.current.date(byAdding: .day, value: minPauseAfterTest, to: Date())
        
        let progress: Progress = (initTrainingIndex, endTrainingIndex, dayToStart?.milliseconds ?? 0)
        initUserProgress(progress)
        
    }
    
    func getTrainingItem(byIndex index: Int) -> TrainingItem {
        return jsonData.items[index]
    }
    
    private func initUserProgress(_ progress: Progress){
        do {
            var realmProgress = self.realm.object(ofType: TrainingProgress.self, forPrimaryKey: TrainingProgress.uniqueKey)
            if(realmProgress == nil){
                realmProgress = TrainingProgress()
            }
            realmProgress?.currentIndex = progress.currentIndex
            realmProgress?.lastIndex = progress.lastIndex
            realmProgress?.startTs = progress.startTs
            
            if let element = realmProgress {
                do {
                    try realm.write {
                        realm.add(element, update: .modified)
                    }
                } catch {
                    print("TrainingProgress write error")
                }
            }
        } catch {
            print("TrainingProgress realm error")
        }
    }
    
    private func getTrainingData(byPushUpsCount pushUpsCount: Int) -> (Int, Int) {
    
        if pushUpsCount >= 100 {
            return (maxTrainingIndex, pushUpsCount)
        }
        
        for (key, value) in jsonData.groups {
            let keys = key.split(separator: ",").map{ Int($0)! }
            if(pushUpsCount >= keys[0] && pushUpsCount <= keys[1]){
                return (value, keys[1])
            }
        }
        return (-1, -1)
    }
    
    
    private class TrainingsJson: Decodable {
        var groups: [String:Int] = [:]
        var items: [TrainingItem]
    }
    
    
}
