//
//  ParticipantViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/22/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class ParticipantViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var participantTableView: UITableView!
    
    // MARK: - Variables
    
    public var matchDetails: Match?
    private var blueTeam: [MatchParticipant] = []
    private var redTeam: [MatchParticipant] = []
    private var blueBans: [ChampionId] = []
    private var redBans: [ChampionId] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillTeams()
        self.fillBans()
    }
    
    // MARK: - Setup
    
    func fillTeams() {
        guard let matchDetails = self.matchDetails else { return }
        let blueTeamId: Long = 100
        for participant in matchDetails.participantsInfo {
            if participant.teamId == blueTeamId {
                self.blueTeam.append(participant)
            }
            else {
                self.redTeam.append(participant)
            }
        }
    }
    
    func fillBans() {
        guard let matchDetails = self.matchDetails else { return }
        let blueTeamId: Long = 100
        for teamInfo in matchDetails.teamsInfo {
            if teamInfo.teamId == blueTeamId {
                self.blueBans = teamInfo.bans.map( { ban in
                    return ban.championId
                })
            }
            else {
                self.redBans = teamInfo.bans.map( { ban in
                    return ban.championId
                })
            }
        }
    }
    
    // MARK: - Functions
    
    func player(for participantId: Int) -> MatchPlayer? {
        return self.matchDetails?.participants.filter( { participant in
            return participant.participantId == participantId
        }).first?.player
    }
    
    func particiantDetails(at indexPath: IndexPath) -> MatchParticipant {
        let teamAtIndexPath: [MatchParticipant] = indexPath.section == 1 ? self.blueTeam : self.redTeam
        return teamAtIndexPath[indexPath.row]
    }
    
    func getChampionImage(championId: ChampionId, splash: Bool, completion: @escaping (UIImage?) -> Void) {
        league.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion, let defaultSkin = champion.images {
                let selectedFormat: ImageWithUrl = splash ? defaultSkin.splash : defaultSkin.square
                selectedFormat.getImage() { (image, error) in
                    completion(image)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getItemImage(itemId: ItemId, completion: @escaping (UIImage?) -> Void) {
        league.getItem(by: itemId) { (item, errorMsg) in
            if let item = item {
                item.image.getImage() { (image, error) in
                    completion(image)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getRuneImage(runePathId: RunePathId, completion: @escaping (UIImage?) -> Void) {
        league.getRunePath(by: runePathId) { (runePath, errorMsg) in
            if let runePath = runePath {
                runePath.image.getImage() { (image, error) in
                    completion(image)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
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
        if let participant = sender as? MatchPlayer {
            summonerVC.summonerNameParameter = participant.summonerName
        }
    }
}

extension ParticipantViewController: UITableViewDataSource {
    
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
            let participantAtIndex: MatchParticipant = self.particiantDetails(at: indexPath)
            return setupParticipantCell(for: participantAtIndex)
        }
    }
    
    func setupBanCell(for blueTeam: Bool) -> BanTableViewCell {
        let newCell: BanTableViewCell = self.participantTableView.dequeueReusableCell(withIdentifier: "banCell") as! BanTableViewCell
        let teamBans: [ChampionId] = blueTeam ? self.blueBans : self.redBans
        for (index, ban) in teamBans.enumerated() {
            let ban: ChampionId = teamBans[index]
            self.getChampionImage(championId: ban, splash: false) { image in
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
    
    func setupParticipantCell(for participant: MatchParticipant) -> ParticipantTableViewCell {
        let newCell: ParticipantTableViewCell = self.participantTableView.dequeueReusableCell(withIdentifier: "participantCell") as! ParticipantTableViewCell
        if let participantIdentity = self.player(for: participant.participantId) {
            newCell.summonerName.text = participantIdentity.summonerName
        }
        newCell.kdaLabel.text = "\(participant.stats.kills)/\(participant.stats.deaths)/\(participant.stats.assists) - \(participant.stats.totalMinionsKilled)/\(participant.stats.neutralMinionsKilled)"
        newCell.rankedSquare.setImage(league.getEmblem(for: participant.highestAchievedSeasonTier ?? RankedTier(.Unranked)!))
        self.getChampionImage(championId: participant.championId, splash: true) { image in
            newCell.championSplashBackground.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item0) { image in
            newCell.item1.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item1) { image in
            newCell.item2.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item2) { image in
            newCell.item3.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item3) { image in
            newCell.item4.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item4) { image in
            newCell.item5.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item5) { image in
            newCell.item6.setImage(image)
        }
        self.getItemImage(itemId: participant.stats.item6) { image in
            newCell.item7.setImage(image)
        }
        if let primaryRunePath = participant.stats.primaryRunePath {
            self.getRuneImage(runePathId: primaryRunePath) { image in
                newCell.rune1.setImage(image)
            }
        }
        if let secondaryRunePath = participant.stats.secondaryRunePath {
            self.getRuneImage(runePathId: secondaryRunePath) { image in
                newCell.rune2.setImage(image)
            }
        }
        return newCell
    }
}

extension ParticipantViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard indexPath.section > 0 else { return }
        let participantAtIndex: MatchParticipant = self.particiantDetails(at: indexPath)
        guard let participantIdentity = self.player(for: participantAtIndex.participantId) else { return }
        self.performSegue(withIdentifier: "showParticipant", sender: participantIdentity)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 70 : 200
    }
}
