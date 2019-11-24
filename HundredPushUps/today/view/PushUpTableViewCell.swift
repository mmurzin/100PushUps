//
//  PushUpTableViewCell.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class PushUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var pushUps: UILabel!
    
    @IBAction func changeExerciseState(_ sender: UISwitch) {
        data?.isCompleted = sender.isOn
    }
    
    private var data:ExerciseItemModel? = nil
    
    func attachData(_ data: ExerciseItemModel) {
        self.data = data
        pushUps.text = "Подходы: \(data.pushUpsCount)"
        statusSwitch.isOn = data.isCompleted
    }
}
