//
//  FeaturedGamesViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/17/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class FeaturedGamesViewController: UIViewController {

    // MARK: - IBOulet
    
    @IBOutlet weak var featuredGamesTableView: UITableView!
    
    // MARK: - Variables
    
    var games: [GameInfo] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFeaturedGames()
    }
    
    // MARK: - Functions
    
    func getFeaturedGames() {
        league.lolAPI.getFeaturedGames(on: preferredRegion) { (featuredGames, errorMsg) in
            if let featuredGames = featuredGames {
                self.games = featuredGames.games
                self.featuredGamesTableView.reload()
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getChampionImage(championId: ChampionId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion, let defaultSkin = champion.images?.loading {
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? GameViewController {
            self.prepareGameVC(destinationVC, sender: sender)
        }
    }
    
    func prepareGameVC(_ gameController: GameViewController, sender: Any?) {
        guard let gameInfo = sender as? GameInfo else {
            print("GameViewController sender is not GameInfo type")
            return
        }
        gameController.game = gameInfo
    }
}

extension FeaturedGamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameAtIndex: GameInfo = self.games[indexPath.row]
        return setupGameCell(for: gameAtIndex)
    }
    
    func setupGameCell(for game: GameInfo) -> GameTableViewCell {
        let newCell: GameTableViewCell = self.featuredGamesTableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
        if let firstParticipant = game.participants.first {
            let presentationChampId: ChampionId = firstParticipant.championId
            self.getChampionImage(championId: presentationChampId) { image in
                newCell.backgroundImage.setImage(image)
            }
        }
        return newCell
    }
}

extension FeaturedGamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameAtIndex: GameInfo = self.games[indexPath.row]
        self.performSegue(withIdentifier: "showGame", sender: gameAtIndex)
    }
}
