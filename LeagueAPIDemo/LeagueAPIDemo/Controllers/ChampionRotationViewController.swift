//
//  ChampionRotationViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/17/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class ChampionRotationViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var championRotationTableView: UITableView!
    
    // MARK: - Variables
    
    var championRotation: [ChampionId] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getChampionRotation()
    }
    
    // MARK: - Functions
    
    func getChampionRotation() {
        league.lolAPI.getChampionRotation(on: preferedRegion) { (rotations, errorMsg) in
            if let rotations = rotations {
                self.championRotation = rotations.rotation
                self.championRotationTableView.reload()
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
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
    
    func getChampionDetail(championId: ChampionId, completion: @escaping (ChampionDetails) -> Void) {
        league.lolAPI.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion {
                completion(champion)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ChampionViewController {
            self.setupChampionVC(destinationVC, sender: sender)
        }
    }
    
    func setupChampionVC(_ championVC: ChampionViewController, sender: Any?) {
        if let championId = sender as? ChampionId {
            championVC.championIdParameter = championId
        }
    }
}

extension ChampionRotationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.championRotation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let championIdAtIndex: ChampionId = self.championRotation[indexPath.row]
        return setupChampionCell(for: championIdAtIndex)
    }
    
    func setupChampionCell(for championId: ChampionId) -> ChampionTableViewCell {
        let newCell: ChampionTableViewCell = self.championRotationTableView.dequeueReusableCell(withIdentifier: "championCell") as! ChampionTableViewCell
        self.getChampionDetail(championId: championId) { championDetais in
            newCell.championName.setText(championDetais.name)
            newCell.championTitle.setText(championDetais.title)
        }
        self.getChampionImage(championId: championId) { image in
            newCell.championSquare.setImage(image)
        }
        return newCell
    }
}

extension ChampionRotationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let championIdAtIndex: ChampionId = self.championRotation[indexPath.row]
        self.performSegue(withIdentifier: "showChampion", sender: championIdAtIndex)
    }
}
