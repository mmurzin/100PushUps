//
//  TodayViewController.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 21.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate  {
    
    @IBOutlet weak var timeoutLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    lazy var viewModel = TodayViewModel(service: ServiceLocator.shared.getService())
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    
    @IBAction func trainingCompleted(_ sender: Any) {
        viewModel.saveProgress(self.exercises)
        if viewModel.isStageCompleted() {
            viewModel.removeProgress()
            openTestDisplay()
        } else {
            loadTodayTraining()
        }
    }
    var exercises: [ExerciseItemModel] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PushUpTableViewCell", bundle: nil), forCellReuseIdentifier: "pushUpCell")
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        loadTodayTraining()
    }
    
    private func loadTodayTraining() {
        self.exercises = viewModel.loadTodayTraining()
        timeoutLabel.text = "Перерыв между подходами: \(viewModel.timeoutValue)"
        timeLabel.text = "Время тренировки: \(viewModel.trainingTime)"
        if(!viewModel.isCanCompleteTraining){
            showWarningAlert()
        }
        heightConstrain.constant = CGFloat(exercises.count * 50)
    }
    
    private func openTestDisplay() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController (withIdentifier: "TestViewController")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    private func showWarningAlert(){
        let alertController = UIAlertController(title: "100 PushUps", message:
            "Вы пока не можете проходить эту тренировку. Перерыв очень важен!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))

        self.present(alertController, animated: true, completion: nil)
    }
}
