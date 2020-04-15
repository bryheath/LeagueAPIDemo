//
//  main.swift
//  LeagueAPI-CLI
//
//  Created by Antoine Clop on 5/9/19.
//  Copyright © 2019 Antoine Clop. All rights reserved.
//

import Foundation
import LeagueAPI

print("LeagueAPI - \(Version.LeagueAPI)")

let league = LeagueAPI(APIToken: "RGAPI-eac8956b-76d1-4edd-9638-8f22e18c0870")
var received = false

func test() {
    guard let queue = Queue(.RankedSolo5V5) else { return }
    guard let tier = RankedTier(.Diamond) else { return }
    
    /*league.riotAPI.getClashPlayers(by: TeamId("7c76ab62-8ad4-43d0-83a0-757e457e2f15"), on: .EUW) { (team, errorMsg) in
           if let team = team {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/
    
    /*league.riotAPI.getClashPlayers(by: SummonerId("l1u59aGq69RycT9It-N-DjdxcVLauJsGX_-LPMauB094Qiw"), on: .EUW) { (players, errorMsg) in
              if let players = players {
                  print("Success!")
              } else {
                  print("Request failed cause: \(errorMsg ?? "No error description")")
              }
       }*/
    
    /*league.riotAPI.getClashTournament(by: TournamentId(2001), on: .EUW) { (tournament, errorMsg) in
           if let tournament = tournament {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/
    
    /*league.riotAPI.getClashTournaments(on: .EUW) { (tournaments, errorMsg) in
           if let tournaments = tournaments {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/
    
    /*league.riotAPI.getClashPlayers(by: SummonerId("0QgJjfjROo4t7MemZVkbNI0DMeXldcSfGsoWeb0XKWAzaTs"), on: .EUW) { (players, errorMsg) in
           if let players = players {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/

    /*
    league.riotAPI.getRunneteraLeaderboard(on: .America) { (players, errorMsg) in
        if let players = players {
            print("Success!")
        } else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
    }*/
    
    /*
    league.riotAPI.getTFTMatch(by: TFTGameId("EUW1_4210310480"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    
    
    /*league.riotAPI.getTFTMatchList(by: SummonerPuuid("8O-V8DGHm3YimSunwz6I6lntBnJVpPexIso6so6DtgXBZMNPnuktCigiLS7AXniMmqJFUvoc3Zrrzw"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    
    
    
    /*league.riotAPI.getTFTSummoner(by: SummonerPuuid("8O-V8DGHm3YimSunwz6I6lntBnJVpPexIso6so6DtgXBZMNPnuktCigiLS7AXniMmqJFUvoc3Zrrzw"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTSummoner(by: AccountId("Tvh3uSJMRiM5crphJJQRvzligztkDSN9QcjsNjimQbDimg"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTSummoner(byName: "Kelmatou", on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTSummoner(by: SummonerId("B5qQc6G9VNAsuHF23OAVtBDZdGnGfVnlFdNBpDAN-MzFHLA"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    
    
    
    
    
    /*league.riotAPI.getTFTRankedEntries(for: SummonerId("B5qQc6G9VNAsuHF23OAVtBDZdGnGfVnlFdNBpDAN-MzFHLA"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getLeague(by: TFTLeagueId("14e87700-b60d-11e9-8a7f-c81f66db01ef"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTChallengerLeague(on: .NA) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTGrandMasterLeague(on: .NA) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTMasterLeague(on: .NA) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.riotAPI.getTFTEntries(on: .NA, division: RankedDivision(tier: tier, divisionRoman: "I"), page: 2) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
}

test()
while (!received) {
    
}
