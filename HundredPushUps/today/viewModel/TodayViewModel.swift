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
            let exercises = self.getExerciseItems(training.sets)
            return exercises
        } else {
            fatalError("TodayViewModel: currentTraining in nil")
        }
    }
    
    private func getExerciseItems(_ items: [Int]) -> [ExerciseItemModel] {
        return items.map{ ExerciseItemModel(pushUpsCount: $0) }
    }
}
