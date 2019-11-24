//
//  TestViewController.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 22.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var valueTextLabel: UILabel!
    @IBOutlet weak var valueSlider: UISlider!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updateSliderValue()
    }
    @IBAction func submitClicked(_ sender: Any) {
        let pushUpsCount = Int(valueSlider.value)
        guard let testResultService: TestResultService = ServiceLocator.shared.getService() else {
            print("progressService = nil error")
            return
        }
        testResultService.savePushUpsCount(pushUpsCount)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController (withIdentifier: "TabsViewController")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSliderValue()
    }
    
    private func updateSliderValue() {
        let sliderValue = Int(valueSlider.value)
        valueTextLabel.text = String(sliderValue)
    }

}
