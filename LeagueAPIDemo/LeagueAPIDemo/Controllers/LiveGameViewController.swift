//
//  LiveGameViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/21/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class LiveGameViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var textbar: UITextField!
    
    // MARK: - Variables

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    func getLiveGame(of summonerName: String) {
        league.lolAPI.getSummoner(byName: summonerName, on: preferedRegion) { (summoner, errorMsg) in
            if let summoner = summoner {
                league.lolAPI.getLiveGame(by: summoner.id, on: .EUW) { (liveGame, errorMsg) in
                    if let liveGame = liveGame {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showGame", sender: liveGame)
                        }
                    }
                    else {
                        print("Request failed cause: \(errorMsg ?? "No error description")")
                    }
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
            self.setupGameVC(destinationVC, sender: sender)
        }
    }
    
    func setupGameVC(_ gameVC: GameViewController, sender: Any?) {
        if let liveGame = sender as? GameInfo {
            gameVC.game = liveGame
        }
    }
}

extension LiveGameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        self.getLiveGame(of: text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
