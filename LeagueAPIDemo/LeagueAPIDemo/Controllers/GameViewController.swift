//
//  GameViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/17/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class GameViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var gameTableView: UITableView!
    
    // MARK: - Variables
    
    public var game: GameInfo?
    private var blueTeam: [Participant] = []
    private var redTeam: [Participant] = []
    private var blueBans: [BannedChampion] = []
    private var redBans: [BannedChampion] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillTeams()
        self.fillBans()
    }
    
    // MARK: - Setup
    
    func fillTeams() {
        guard let game = self.game else { return }
        let blueTeamId: Long = 100
        for participant in game.participants {
            if participant.teamId == blueTeamId {
                self.blueTeam.append(participant)
            }
            else {
                self.redTeam.append(participant)
            }
        }
    }
    
    func fillBans() {
        guard let game = self.game else { return }
        let blueTeamId: Long = 100
        for bannedChampion in game.bannedChampions {
            if bannedChampion.teamId == blueTeamId {
                self.blueBans.append(bannedChampion)
            }
            else {
                self.redBans.append(bannedChampion)
            }
        }
    }
    
    // MARK: - Functions
    
    func participant(at indexPath: IndexPath) -> Participant {
        let teamAtIndexPath: [Participant] = indexPath.section == 1 ? self.blueTeam : self.redTeam
        return teamAtIndexPath[indexPath.row]
    }
    
    func getChampionImage(championId: ChampionId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getChampionDetails(by: championId) { (champion, errorMsg) in
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
    
    func getSummonerImage(profileIconId: ProfileIconId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getProfileIcon(by: profileIconId) { (profileIcon, errorMsg) in
            if let profileIcon = profileIcon {
                profileIcon.profileIcon.getImage() { (image, error) in
                    completion(image)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getChampionMastery(summonerId: SummonerId, championId: ChampionId, completion: @escaping (Int?) -> Void) {
        league.lolAPI.getChampionMastery(by: summonerId, for: championId, on: preferredRegion) { (championMastery, errorMsg) in
            if let championMastery = championMastery {
                completion(championMastery.championLevel)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getSummonerBestRank(summonerId: SummonerId, completion: @escaping (RankedTier) -> Void) {
        league.lolAPI.getRankedEntries(for: summonerId, on: preferredRegion) { (rankedPositions, errorMsg) in
            if let rankedPositions = rankedPositions {
                let rankedTiers: [RankedTier] = rankedPositions.map( { position in
                    return position.tier!
                })
                let orderedTiers: [RankedTier.Tiers] = [.Challenger, .GrandMaster, .Master, .Diamond, .Platinum, .Gold, .Silver, .Bronze, .Iron]
                for tier in orderedTiers {
                    if let bestTier = rankedTiers.filter( { rankedTier in return rankedTier.tier == tier }).first {
                        completion(bestTier)
                        return
                    }
                }
                completion(RankedTier(.Unranked)!)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getSummonerRanked(participant: Participant, completion: @escaping (RankedTier) -> Void) {
        if let summonerId = participant.summonerId {
            self.getSummonerBestRank(summonerId: summonerId) { bestRank in
                completion(bestRank)
            }
        }
        else {
            league.lolAPI.getSummoner(byName: participant.summonerName, on: preferredRegion) { (summoner, errorMsg) in
                if let summoner = summoner {
                    self.getSummonerBestRank(summonerId: summoner.id) { bestRank in
                        completion(bestRank)
                    }
                }
                else {
                    print("Request failed cause: \(errorMsg ?? "No error description")")
                }
            }
        }
    }
    
    func getChampionMastery(participant: Participant, completion: @escaping (Int?) -> Void) {
        if let summonerId = participant.summonerId {
            self.getChampionMastery(summonerId: summonerId, championId: participant.championId) { masteryLevel in
                completion(masteryLevel)
            }
        }
        else {
            league.lolAPI.getSummoner(byName: participant.summonerName, on: preferredRegion) { (summoner, errorMsg) in
                if let summoner = summoner {
                    self.getChampionMastery(summonerId: summoner.id, championId: participant.championId) { masteryLevel in
                        completion(masteryLevel)
                    }
                }
                else {
                    print("Request failed cause: \(errorMsg ?? "No error description")")
                    completion(nil)
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SummonerViewController {
            self.setupSummonerVC(destinationVC, sender: sender)
        }
    }
    
    func setupSummonerVC(_ summonerVC: SummonerViewController, sender: Any?) {
        if let participant = sender as? Participant {
            summonerVC.summonerNameParameter = participant.summonerName
        }
    }
}

extension GameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return self.blueTeam.count
        case 2:
            return self.redTeam.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Banned Champions"
        case 1:
            return "Blue Team"
        case 2:
            return "Red Team"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return setupBanCell(for: indexPath.row == 0)
        }
        else {
            let participantAtIndex: Participant = self.participant(at: indexPath)
            return setupParticipantCell(for: participantAtIndex)
        }
    }
    
    func setupBanCell(for blueTeam: Bool) -> BanTableViewCell {
        let newCell: BanTableViewCell = self.gameTableView.dequeueReusableCell(withIdentifier: "banCell") as! BanTableViewCell
        let teamBans: [BannedChampion] = blueTeam ? self.blueBans : self.redBans
        for (index, ban) in teamBans.enumerated() {
            let ban: BannedChampion = teamBans[index]
            self.getChampionImage(championId: ban.championId) { image in
                var imageView: UIImageView {
                    switch index {
                    case 0:
                        return newCell.banChampionSquare1
                    case 1:
                        return newCell.banChampionSquare2
                    case 2:
                        return newCell.banChampionSquare3
                    case 3:
                        return newCell.banChampionSquare4
                    default:
                        return newCell.banChampionSquare5
                    }
                }
                imageView.setImage(image)
            }
        }
        if blueTeam {
            newCell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        else {
            newCell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        return newCell
    }
    
    func setupParticipantCell(for participant: Participant) -> PlayerTableViewCell {
        let newCell: PlayerTableViewCell = self.gameTableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerTableViewCell
        self.getChampionImage(championId: participant.championId) { image in
            newCell.championSquare.setImage(image)
        }
        self.getSummonerImage(profileIconId: participant.profileIconId) { image in
            newCell.summonerSquare.setImage(image)
        }
        self.getSummonerRanked(participant: participant) { bestRankedTier in
            newCell.rankedSquare.setImage(league.lolAPI.getEmblem(for: bestRankedTier))
        }
        newCell.summonerName.text = participant.summonerName
        self.getChampionMastery(participant: participant) { masteryLevel in
            if let masteryLevel = masteryLevel {
                newCell.masteryLabel.setText("Mastery level \(masteryLevel)")
            }
            else {
                newCell.masteryLabel.setText(nil)
            }
        }
        return newCell
    }
}

extension GameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard indexPath.section > 0 else { return }
        let participantAtIndex: Participant = self.participant(at: indexPath)
        self.performSegue(withIdentifier: "showParticipant", sender: participantAtIndex)
    }
}
