//
//  SummonerViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class SummonerViewController: UIViewController {

    // MARK: - IBOulet
    
    @IBOutlet weak var textbar: UITextField!
    @IBOutlet weak var summonerProfileIcon: UIImageView!
    @IBOutlet weak var summonerName: UILabel!
    @IBOutlet weak var summonerLevel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - UI
    
    func updateUI(for summoner: Summoner) {
        self.summonerProfileIcon.image = su
    }
    
    // MARK: - Functions
    
    func getInfo(of summonerName: String) {
        league.riotAPI.getSummoner(byName: summonerName, on: preferedRegion) { (summoner, errorMsg) in
            if let summoner = summoner {
                
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
}

extension SummonerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        self.getInfo(of: text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
