//
//  TodayViewModel.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

class TodayViewModel {
    
    
    let trainingService:TrainingService
    private var currentTraining: TrainingItem?
    
    init(service: TrainingService?) {
        if let s = service {
            trainingService = s
        } else {
            fatalError("TrainingService can't be nil")
        }
    }
    
    func loadTodayTraining() ->  [ExerciseItemModel] {
        let item = trainingService.getCurrentTraining()
        if let training = item {
            self.currentTraining = training
            let exercises = self.getExerciseItems(training.sets)
            return exercises
        } else {
            fatalError("TodayViewModel: currentTraining in nil")
        }
    }
    
    func saveProgress(_ exercises: [ExerciseItemModel])  {
        if let training = self.currentTraining {
            trainingService.saveHistory(training: training, exercises:exercises)
            trainingService.updateProgress(training: training, exercises:exercises)
        }
    }
    
    func isStageCompleted() -> Bool {
        if let training = self.currentTraining {
            return trainingService.isStageCompleted(trainingId: training.id)
        } else {
            return false
        }
    }
    
    func removeProgress() {
        trainingService.removeProgress()
    }
    
    private func getExerciseItems(_ items: [Int]) -> [ExerciseItemModel] {
        return items.map{ ExerciseItemModel(pushUpsCount: $0) }
    }
}
