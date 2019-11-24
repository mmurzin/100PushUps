//
//  HistoryViewController.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 21.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let viewModel = HistoryViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    var historyItems: [TrainingHistoryItem] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        loadTrainingsHistory()
    }
    
    func loadTrainingsHistory() {
        self.historyItems = viewModel.loadTrainingsHistory()
        if(self.historyItems.count == 0) {
            showEmptyListAlert()
        }
    }
    
    private func showEmptyListAlert(){
        let alertController = UIAlertController(title: "100 PushUps", message:
            "У вас пока нет ни одной тренировки!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))

        self.present(alertController, animated: true, completion: nil)
    }

}
