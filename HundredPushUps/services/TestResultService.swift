//
//  ProgressService.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 22.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RealmSwift


class TestResultService {
    private let realm = try! Realm()
    var testResult: TestResult?
    
    func hasTestResult() -> Bool {
        self.testResult = getTestResults()
        return self.testResult != nil
    }
    
    func savePushUpsCount(_ count: Int){
        var result = getTestResults()
        
        if(result == nil) {
            result = TestResult()
        }
        
        if let element = result {
            do {
                try realm.write {
                    result?.pushUpsCount = count
                    realm.add(element, update: .modified)
                }
            } catch {
                print("TestResult write error")
            }
        }
        
        let trainingService: TrainingService? = ServiceLocator.shared.getService()
        trainingService?.setInitPushUps(count)
    }
    
    private func getTestResults() -> TestResult?{
        do {
            return self.realm.object(ofType: TestResult.self, forPrimaryKey: TestResult.uniqueKey)
        } catch {
            return nil
        }
    }
}
