//
//  HistoryViewController-DataSource.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 24.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

import UIKit
import Foundation

extension HistoryViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .tableCellIdentifier, for: indexPath)
        let historyItem = historyItems[indexPath.row]
        let date = Date(milliseconds: historyItem.timeMs)
        
        cell.detailTextLabel?.text = viewModel.formatDate(date)
        cell.textLabel?.text = "Этап \(historyItem.trainingStage). Тренировка \(historyItem.trainingPosition)"
        
        
        return cell
    }

}

private extension String {
    static let tableCellIdentifier = "historyTrainingCell"
}
