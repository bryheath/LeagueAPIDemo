//
//  RunneteraLeaderboardViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 4/15/20.
//  Copyright © 2020 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class RunneteraLeaderboardViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var leaderboardTitle: UILabel!
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    // MARK: - Variables
    
    private var leaderboardPlayers: [RunneteraPlayer] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leaderboardTitle.text = "Leaderboard for \(preferedWorldRegion.rawValue)"
        self.getLeaderboardPlayers(worldRegion: preferedWorldRegion)
    }
    
    // MARK: - Functions
    
    func getLeaderboardPlayers(worldRegion: WorldRegion) {
        league.lorAPI.getLeaderboard(on: worldRegion) { (leaderboard, errorMsg) in
            if let leaderboard = leaderboard {
                self.leaderboardPlayers = leaderboard
                self.leaderboardTableView.reload()
            } else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
}

extension RunneteraLeaderboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaderboardPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerAtIndex: RunneteraPlayer = self.leaderboardPlayers[indexPath.row]
        return setupPlayerCell(player: playerAtIndex)
    }
    
    func setupPlayerCell(player: RunneteraPlayer) -> RunneteraLeaderboardTableViewCell {
        let newCell: RunneteraLeaderboardTableViewCell = self.leaderboardTableView.dequeueReusableCell(withIdentifier: "runneteraRankCell") as! RunneteraLeaderboardTableViewCell
        newCell.rank.setText("#\(player.rank + 1)") // 0 based ranking
        newCell.playerName.setText(player.name)
        return newCell
    }
}
