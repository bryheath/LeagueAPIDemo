//
//  RequestListViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class RequestListViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var requestTableView: UITableView!
    
    // MARK: - Variables
    
    public var requests: [Request] = [
        Request(.FeaturedGames, image: #imageLiteral(resourceName: "maokai_victorious")),
        Request(.SummonerByName, image: #imageLiteral(resourceName: "ryze_splash")),
        Request(.LiveGame , image: #imageLiteral(resourceName: "lucian_project")),
        Request(.MatchHistory, image: #imageLiteral(resourceName: "garen_splash")),
        Request(.ChampionRotation, image: #imageLiteral(resourceName: "bard_bard")),
        Request(.ChampionInfo , image: #imageLiteral(resourceName: "arcade_ahri")),
        Request(.Status, image: #imageLiteral(resourceName: "heimer_splash")),
        Request(.VerificationCode, image: #imageLiteral(resourceName: "irelia_splash"))
    ]
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.setAllChannels(enabled: true)
    }
}

extension RequestListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestAtIndex: Request = self.requests[indexPath.row]
        return setupRequestCell(for: requestAtIndex)
    }
    
    func setupRequestCell(for request: Request) -> RequestTableViewCell {
        let newCell: RequestTableViewCell = self.requestTableView.dequeueReusableCell(withIdentifier: "requestCell") as! RequestTableViewCell
        newCell.backgroundImage.image = request.image
        newCell.requestTitle.text = request.title
        return newCell
    }
}

extension RequestListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let requestAtIndex: Request = self.requests[indexPath.row]
        self.performSegue(withIdentifier: "\(requestAtIndex.title)Request", sender: requestAtIndex)
    }
}
