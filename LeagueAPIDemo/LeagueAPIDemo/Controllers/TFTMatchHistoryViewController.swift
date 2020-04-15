//
//  TFTMatchHistoryViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 4/15/20.
//  Copyright © 2020 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class TFTMatchHistoryViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var textbar: UITextField!
    @IBOutlet weak var tftmatchHistoryTableView: UITableView!
    
    // MARK: - Variables
    
    private var matchIds: [TFTGameId] = []
    private var matchInfos: [TFTGameId : TFTMatchInfo] = [:]
    private var playerMatchStats: [TFTGameId : TFTParticipant] = [:]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    func getMatchList(for summonerName: String) {
        league.riotAPI.getTFTSummoner(byName: summonerName, on: preferedRegion) { (summoner, errorMsg) in
            if let summoner = summoner {
                league.riotAPI.getTFTMatchList(by: summoner.puuid, on: preferedRegion) { (tftgameids, errorMsg) in
                    if let tftgameids = tftgameids {
                        self.matchIds = tftgameids
                        for tftgameid in tftgameids {
                            self.getTFTPlayerMatchDetails(for: tftgameid, summoner: summoner) { (playerStats) in
                                self.tftmatchHistoryTableView.reload()
                            }
                        }
                    } else {
                        print("Request failed cause: \(errorMsg ?? "No error description")")
                    }
                }
            } else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getTFTPlayerMatchDetails(for tftgameId: TFTGameId, summoner: Summoner, completion: @escaping (TFTParticipant) -> Void) {
        if let localGameStatsDetails = self.playerMatchStats[tftgameId] {
            completion(localGameStatsDetails)
        }
        else {
            league.riotAPI.getTFTMatch(by: tftgameId, on: preferedRegion) { (match, errorMsg) in
                if let match = match {
                    self.matchInfos[tftgameId] = match.info
                    let playerStats = match.info.participants.first { (participant) in {
                        return participant.puuid == summoner.puuid
                        }()}
                    if let playerStats = playerStats {
                        self.playerMatchStats[tftgameId] = playerStats
                        completion(playerStats)
                    }
                } else {
                    print("Request failed cause: \(errorMsg ?? "No error description")")
                }
            }
        }
    }
    
    func getChampionImage(championId: ChampionId, completion: @escaping (UIImage?) -> Void) {
        league.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion, let defaultSkin = champion.images?.square {
                defaultSkin.getImage() { (image, error) in
                    completion(image)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    // MARK: - Navigation
}

extension TFTMatchHistoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        self.getMatchList(for: text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension TFTMatchHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchAtIndex: TFTGameId = self.matchIds[indexPath.row]
        let statsForMatchAtIndex: TFTParticipant? = self.playerMatchStats[matchAtIndex]
        let infoForMatchAtIndex: TFTMatchInfo? = self.matchInfos[matchAtIndex]
        return self.setupMatchCell(matchStats: statsForMatchAtIndex, matchInfo: infoForMatchAtIndex)
    }
    
    func setupMatchCell(matchStats: TFTParticipant?, matchInfo: TFTMatchInfo?) -> TFTMatchTableViewCell {
        let newCell: TFTMatchTableViewCell = self.tftmatchHistoryTableView.dequeueReusableCell(withIdentifier: "tftmatchCell") as! TFTMatchTableViewCell
        
        guard let matchStats = matchStats, let matchInfo = matchInfo else { return newCell }
        
        //newCell.CompanionSquare.setImage(matchStats.companion.skinId)
        newCell.finalPosition.setText("\(matchStats.placement)")
        newCell.matchDate.setText(matchInfo.gameDate.toString(format: "dd/MM/yy"))
        if matchStats.placement <= 3 {
            var cellColor: UIColor {
                switch matchStats.placement {
                case 1:
                    return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                case 2:
                    return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                case 3:
                    return #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                default:
                    return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
            }
            DispatchQueue.main.async {
                newCell.backgroundColor = cellColor
            }
        }
        return newCell
    }
}
