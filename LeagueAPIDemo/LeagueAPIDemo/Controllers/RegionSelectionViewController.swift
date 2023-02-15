//
//  RegionSelectionViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/24/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class RegionSelectionViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var regionTableView: UITableView!
    
    // MARK: - Variables
    
    private let allRegions: [Region] = [.BR, .EUNE, .EUW, .JP, .KR, .LAN, .LAS, .NA, .OCE, .PBE, .RU, .TR]

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension RegionSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allRegions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let regionAtIndex: Region = self.allRegions[indexPath.row]
        return self.setupRegionCell(for: regionAtIndex)
    }
    
    func setupRegionCell(for region: Region) -> UITableViewCell {
        let newCell: UITableViewCell = self.regionTableView.dequeueReusableCell(withIdentifier: "regionCell")!
        newCell.textLabel?.setText(region.rawValue)
        if region == preferredRegion {
            newCell.accessoryType = .checkmark
        }
        else {
            newCell.accessoryType = .none
        }
        return newCell
    }
}

extension RegionSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let regionAtIndex: Region = self.allRegions[indexPath.row]
        preferredRegion = regionAtIndex
        tableView.reloadData()
    }
}
