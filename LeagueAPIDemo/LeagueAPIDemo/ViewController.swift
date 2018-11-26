//
//  ViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 11/13/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let league = LeagueAPI(APIToken: "RGAPI-3ea551e2-a2ee-4352-bf81-d6e2f9c3cf01")
        Logger.setAllChannels(enabled: false)
        league.riotAPI.getSummoner(byName: "Hanoki", on: .EUW) { (summoner, errorMsg) in
            if let summoner = summoner {
                league.riotAPI.getMatchList(by: AccountId(summoner.accountId.value), on: .EUW) { (matchList, errorMsg) in
                    if let matchList = matchList {
                        league.getChampionDetails(by: ChampionId(matchList.matches.first!.championId.value)) { (champion, errorMsg) in
                            if let champion = champion {
                                print("Success!")
                            }
                            else {
                                print("Request failed cause: \(errorMsg ?? "No error description")")
                            }
                        }
                    }
                    else {
                        print("Request failed cause: \(errorMsg ?? "No error description")")
                    }
                }            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        
    }
}
