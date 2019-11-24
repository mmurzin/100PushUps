//
//  TodayViewController-UITableViewDataSource.swift
//  HundredPushUps
//
//  Created by Murzin Mikhail on 23.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation


import UIKit
import Foundation

extension TodayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Упражнения"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .tableCellIdentifier, for: indexPath) as! PushUpTableViewCell
        cell.attachData(exercises[indexPath.row])
        return cell
    }

}

private extension String {
    static let tableCellIdentifier = "pushUpCell"
}

