//
//  TodayViewController.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 21.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate  {
    
    lazy var viewModel = TodayViewModel(service: ServiceLocator.shared.getService())
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    
    @IBAction func trainingCompleted(_ sender: Any) {
        viewModel.saveProgress(self.exercises)
        if viewModel.isStageCompleted() {
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
        heightConstrain.constant = CGFloat(exercises.count * 50)
    }
    
    private func openTestDisplay() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController (withIdentifier: "TestViewController")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}
