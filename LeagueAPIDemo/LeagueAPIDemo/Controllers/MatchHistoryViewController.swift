//
//  MatchHistoryViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/22/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class MatchHistoryViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var textbar: UITextField!
    @IBOutlet weak var matchHistoryTableView: UITableView!
    
    // MARK: - Variables
    
    private var summoner: Summoner?
    private var matches: [LOLMatchId] = []
    private var matchDetails: [LOLMatchId : Match] = [:]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    func getMatchList(for summonerName: String) {
        league.lolAPI.getSummoner(byName: summonerName, on: preferredRegion) { (summoner, errorMsg) in
            if let summoner = summoner {
                self.summoner = summoner
                league.lolAPI.getMatchList(by: summoner.puuid, on: preferredRegion, count: 20) { (matchList, errorMsg) in
                   
//                    if let matchList = matchList {
//                        matchList.
////                        self.matches = matchList
//                        self.matchHistoryTableView.reload()
//                    }
//                    else {
//                        print("Request failed cause: \(errorMsg ?? "No error description")")
//                    }
                }
                
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getMatchDetails(matchId: LOLMatchId, completion: @escaping (Match?) -> Void) {
        if let localGameDetails = self.matchDetails[matchId] {
            completion(localGameDetails)
        }
        else {
            league.lolAPI.getMatch(by: matchId, on: preferredRegion) { (game, errorMsg) in
                if let game = game {
                    self.matchDetails[matchId] = game
                    completion(game)
                }
                else {
                    print("Request failed cause: \(errorMsg ?? "No error description")")
                }
            }
        }
    }
    
    func getChampionImage(participant: MatchParticipant, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getChampionDetails(by: participant.championId) { (champion, errorMsg) in
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
    
    
    func getSummonerSpellImage(summonerSpellId: SummonerSpellId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getSummonerSpell(by: summonerSpellId) { (summonerSpell, errorMsg) in
            if let summonerSpell = summonerSpell {
                summonerSpell.image.getImage() { (image, _) in
                    completion(image)
                }
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
                completion(nil)
            }
        }
    }
    
    func getSummonerSpellImages(participant: MatchParticipant, completion: @escaping (UIImage?, UIImage?) -> Void) {
        var spell1Image: UIImage?
        var spell2Image: UIImage?
        var received: Int = 0
        self.getSummonerSpellImage(summonerSpellId: participant.summoner1Id) { image in
            spell1Image = image
            received += 1
            if received == 2 {
                completion(spell1Image, spell2Image)
            }
        }
        self.getSummonerSpellImage(summonerSpellId: participant.summoner2Id) { image in
            spell2Image = image
            received += 1
            if received == 2 {
                completion(spell1Image, spell2Image)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ParticipantViewController {
            self.setupParticipantVC(destinationVC, sender: sender)
        }
    }
    
    func setupParticipantVC(_ participantVC: ParticipantViewController, sender: Any?) {
        guard let matchDetails = sender as? Match else { return }
        participantVC.matchDetails = matchDetails
    }
}

extension MatchHistoryViewController: UITextFieldDelegate {
    
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

extension MatchHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchAtIndex: LOLMatchId = self.matches[indexPath.row]
        return self.setupMatchCell(matchId: matchAtIndex)
    }
    
    func setupMatchCell(matchId: LOLMatchId) -> MatchTableViewCell {
        let newCell: MatchTableViewCell = self.matchHistoryTableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchTableViewCell
        guard let summoner = self.summoner else { return newCell }
        self.getMatchDetails(matchId: matchId) { matchDetails in
            if let matchDetails = matchDetails {
                if let player = matchDetails.info.participants.first(where: { $0.summonerId == summoner.id}) {
                    if player.win {
                        DispatchQueue.main.async {
                            newCell.backgroundColor = player.win ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }

                    self.getChampionImage(participant: player) { image in
                        newCell.championSquare.setImage(image)
                    }
                    self.getSummonerSpellImages(participant: player) { (spell1Image, spell2Image) in
                        newCell.spell1Square.setImage(spell1Image)
                        newCell.spell2Square.setImage(spell2Image)
                    }
                }

                newCell.matchDuration.setText("\(matchDetails.info.gameDuration)")
                
                let timeString = Datetime(timestamp: matchDetails.info.gameStartTimestamp).toString(format: "dd/MM/yy")
                newCell.matchDate.setText(timeString)
                newCell.mapName.setText(Map(Long(matchDetails.info.mapId)).note)
            }
            
        }
        
        
        
        
                                //queue.place.rawValue)
        return newCell
    }
}

extension MatchHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let matchAtIndex: LOLMatchId = self.matches[indexPath.row]
        guard let matchDetails = self.matchDetails[matchAtIndex] else { return }
        self.performSegue(withIdentifier: "showParticipants", sender: matchDetails)
    }
}

