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
        self.historyItems = viewModel.loadTrainingsHistory()
    }

}
