//
//  ChampionViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/21/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class ChampionViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var textbar: UITextField!
    @IBOutlet weak var championBackground: UIImageView!
    @IBOutlet weak var championName: UILabel!
    @IBOutlet weak var championTitle: UILabel!
    @IBOutlet weak var championDescription: UITextView!
    @IBOutlet weak var championSpellsTableView: UITableView!
    
    // MARK: - Variables
    
    public var championIdParameter: ChampionId?
    private var championDetails: ChampionDetails?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.championName.text = nil
        self.championTitle.text = nil
        self.championDescription.text = nil
        self.applyChampionIdParameter()
    }
    
    // MARK: - Setup
    
    func applyChampionIdParameter() {
        guard let championId = self.championIdParameter else { return }
        self.getChampionDetail(championId: championId)
    }
    
    // MARK: - UI
    
    func updateUI(for champion: ChampionDetails) {
        self.championDetails = champion
        self.getChampionImage(championId: champion.championId) { image in
            self.championBackground.setImage(image)
        }
        self.championName.setText(champion.name)
        self.championTitle.setText(champion.title)
        self.championDescription.setText(champion.presentationText)
        self.championSpellsTableView.reload()
    }
    
    // MARK: - Functions
    
    func getChampionImage(championId: ChampionId, completion: @escaping (UIImage?) -> Void) {
        league.getChampionDetails(by: championId) { (champion, errorMsg) in
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
    
    func getChampionDetail(championId: ChampionId) {
        league.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion {
                self.updateUI(for: champion)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getChampionDetail(championName: String) {
        league.getChampionDetails(byName: championName) { (champion, errorMsg) in
            if let champion = champion {
                self.updateUI(for: champion)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
}

extension ChampionViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        self.getChampionDetail(championName: text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ChampionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let championDetails = self.championDetails {
            return championDetails.spells.count + 1 // spells + passive
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let championDetails = self.championDetails else { return SpellTableViewCell() }
        if indexPath.row == 0 {
            return setupSpellCell(name: championDetails.passive.name, image: championDetails.passive.image)
        }
        else {
            let spellAtIndex: ChampionSpell = championDetails.spells[indexPath.row - 1]
            return setupSpellCell(name: spellAtIndex.name, image: spellAtIndex.image)
        }
    }
    
    func setupSpellCell(name: String, image: ImageWithUrl) -> SpellTableViewCell {
        let newCell: SpellTableViewCell = self.championSpellsTableView.dequeueReusableCell(withIdentifier: "spellCell") as! SpellTableViewCell
        image.getImage() { (image, error) in
            newCell.spellImage.setImage(image)
        }
        newCell.spellName.setText(name)
        return newCell
    }
}

extension ChampionViewController: UITableViewDelegate {
    
}
