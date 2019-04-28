//
//  StatusViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 4/28/19.
//  Copyright © 2019 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class StatusViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var serviceStatusTableView: UITableView!
    
    // MARK: - Variables
    
    private var statusInfos: ServiceStatus?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusTitle.text = nil
        self.getStatusInfos(region: preferedRegion)
    }
    
    // MARK: - UI
    
    func updateUI(for status: ServiceStatus?) {
        self.statusInfos = status
        self.statusTitle.setText("Server Status for \(status?.name ?? "Unknown")")
        self.serviceStatusTableView.reload()
    }
    
    // MARK: - Functions
    
    func getStatusInfos(region: Region) {
        league.riotAPI.getStatus(on: region) { (status, errorMsg) in
            if let status = status {
                self.updateUI(for: status)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
}

extension StatusViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let statusInfos = self.statusInfos {
            return statusInfos.services.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let statusInfos = self.statusInfos else { return StatusTableViewCell() }
        let serviceAtIndex: Service = statusInfos.services[indexPath.row]
        return setupStatusCell(service: serviceAtIndex.name, status: serviceAtIndex.status)
    }
    
    func setupStatusCell(service: String, status: String) -> StatusTableViewCell {
        let newCell: StatusTableViewCell = self.serviceStatusTableView.dequeueReusableCell(withIdentifier: "serviceCell") as! StatusTableViewCell
        newCell.serviceName.setText(service)
        newCell.serviceStatus.setText(status)
        return newCell
    }
}

extension StatusViewController: UITableViewDelegate {
    
}
