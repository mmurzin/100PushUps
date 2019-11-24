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

class TrainingService {
    
    private let jsonData: TrainingsJson
    private let realm = try! Realm()
    private let maxTrainingIndex: Int
    typealias Progress = (currentIndex: Int, lastIndex: Int, startTs: Int64)
    private var trainingProgress: TrainingProgress?
    
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
    
    func getCurrentTraining() -> TrainingItem? {
        do {
            let realmProgress = self.realm.object(ofType: TrainingProgress.self, forPrimaryKey: TrainingProgress.uniqueKey)
            if let index = realmProgress?.currentIndex {
                self.trainingProgress = realmProgress
                return getTrainingItem(byIndex: index)
            } else {
                return nil
            }
        } catch {
            print("TrainingProgress realm error")
        }
    }
    
    func getTrainingDate() -> Date {
        return Date(milliseconds: self.trainingProgress!.startTs)
    }
    
    func updateProgress(training: TrainingItem, exercises: [ExerciseItemModel]){
        
        
        
        if let progress = self.trainingProgress {
            let dayToStart = Calendar.current.date(byAdding: .day, value: training.daysPause, to: Date(milliseconds: progress.startTs))!
            if !isLastTrainingInStage(progress.lastIndex, training.id) {
                do {
                    try realm.write {
                        progress.currentIndex = progress.currentIndex + 1
                        progress.startTs = dayToStart.milliseconds
                        realm.add(progress, update: .modified)
                    }
                } catch {
                    print("TrainingProgress write error")
                }
                
            } else {
                
            }
        }
    }
    
    func saveHistory(training: TrainingItem, exercises: [ExerciseItemModel]){
        let progress = exercises.map{ "\($0.pushUpsCount):\($0.isCompleted.intValue)"  }
        let progressValue = progress.joined(separator: ",")
        let descriptionData = getTrainingDescription(byId: training.id)
        let nowMs = Date().milliseconds
        do {
            try realm.write {
                let item = TrainingHistoryItem()
                item.progress = progressValue
                item.timeMs = nowMs
                item.trainingStage = descriptionData.0
                item.trainingPosition = descriptionData.1
                realm.add(item, update: .modified)
            }
        } catch {
            print("TrainingHistoryItem write error")
        }
    }
    
    func isStageCompleted(trainingId: Int) -> Bool {
        if let progress = self.trainingProgress {
            return progress.lastIndex == trainingId
        }
        return false
    }
    
    func removeProgress() {
        let service: TestResultService? = ServiceLocator.shared.getService()
        service?.removeTestResult()
    }
    
    private func getTrainingDescription(byId id: Int) -> (Int, Int) {
        let keys = jsonData.groups.keys.sorted {
            return jsonData.groups[$0]! < jsonData.groups[$1]!
        }
        var stage = 0
        var trainingPosition = 0
        for key in keys {
            let stageIndex = jsonData.groups[key]! 
            if(id >= stageIndex){
                stage += 1
                trainingPosition = id - stageIndex
            }
        }
        trainingPosition += 1
        return (stage, trainingPosition)
    }
    
    private func isLastTrainingInStage(_ lastIndex: Int, _ trainingId: Int) -> Bool{
        return lastIndex == trainingId
    }
    
    private func initUserProgress(_ progress: Progress){
        do {
            var realmProgress = self.realm.object(ofType: TrainingProgress.self, forPrimaryKey: TrainingProgress.uniqueKey)
            if(realmProgress == nil){
                realmProgress = TrainingProgress()
            }
            
            if let element = realmProgress {
                do {
                    try realm.write {
                        realmProgress?.currentIndex = progress.currentIndex
                        realmProgress?.lastIndex = progress.lastIndex
                        realmProgress?.startTs = progress.startTs
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

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
