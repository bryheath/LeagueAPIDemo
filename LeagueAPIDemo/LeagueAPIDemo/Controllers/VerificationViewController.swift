//
//  VerificationViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 4/28/19.
//  Copyright © 2019 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class VerificationViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var resultBackground: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - Variables
    
    private let expectedCode: String = "LeagueAPI"
    private var summonerId: SummonerId?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if (preferredSummoner.isEmpty) {
            self.instructions.text = "You must set preferredSummoner in code before trying this"
            self.verifyButton.isEnabled = false
        } else {
            self.instructions.text = "From \(preferredSummoner) LoL client, enter verification code \"LeagueAPI\""
        }
    }
    
    // MARK: - UI
    
    func updateUI(for verificationCode: String?) {
        let codeIsValide: Bool = (verificationCode == self.expectedCode)
        DispatchQueue.main.async {
            self.resultBackground.isHidden = false
            self.resultBackground.backgroundColor = codeIsValide ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.9403072596, green: 0.1467479765, blue: 0.1850506067, alpha: 1)
            self.resultLabel.text = codeIsValide ? "Valid" : (verificationCode == nil ? "Not Entered" : "Invalid")
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func verifyCode(sender: UIButton) {
        if let summonerId = self.summonerId {
            self.getVerificationCode(summonerId: summonerId, region: preferredRegion)
        } else {
            self.getSummonerId(summonerName: preferredSummoner, region: preferredRegion) { () in
                self.verifyCode(sender: sender)
            }
        }
    }
    
    // MARK: - Functions
    
    func getSummonerId(summonerName: String, region: Region, handler: @escaping () -> Void = { () in }) {
        league.lolAPI.getSummoner(byName: summonerName, on: region) { (summoner, errorMsg) in
            if let summoner = summoner {
                self.summonerId = summoner.id
                handler()
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getVerificationCode(summonerId: SummonerId, region: Region) {
        league.lolAPI.getThirdPartyVerificationCode(by: summonerId, on: region) { (verificationCode, errorMsg) in
            self.updateUI(for: verificationCode)
        }
    }
}
