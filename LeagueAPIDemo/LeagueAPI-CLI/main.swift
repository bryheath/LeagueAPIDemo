//
//  main.swift
//  LeagueAPI-CLI
//
//  Created by Antoine Clop on 5/9/19.
//  Copyright © 2019 Antoine Clop. All rights reserved.
//

import Foundation
import Cocoa
import LeagueAPI

print("LeagueAPI - \(Version.LeagueAPI)")

let league = LeagueAPI(APIToken: "RGAPI-fe7964ce-9f8e-4b38-a957-7f94e8b002ba")
var received = false

func test() {
    guard let queue = Queue(.RankedSolo5V5) else { return }
    guard let tier = RankedTier(.Diamond) else { return }

    /*let trait = league.tftAPI.getTraitInfos(byName: "Blademaster")
    if let trait = trait {
        print("Success!")
    } else {
        print("Trait no found")
    }*/
    
    /*let galaxy = league.tftAPI.getGalaxy(byName: "Superdense Galaxy")
    if let galaxy = galaxy {
        print("Success!")
    } else {
        print("Galaxy not found")
    }*/
    
    /*let champion = league.tftAPI.getChampion(byName: "Ahri")
    if let champion = champion {
        print("Success!")
    } else {
        print("Champion not found")
    }*/
    
    /*let item = league.tftAPI.getItem(byId: TFTItemId(1))
    if let item = item {
        print("Success!")
    } else {
        print("Item not found")
    }*/
    
    /*league.riotAPI.getAccountActiveShards(puuid: SummonerPuuid("Mopk9O_5xL3InZzRnXOMW0ay0FDpTcfKwjeWMLDLvVZhNa17JsrjXJt8jRfxq23R_Ct5RHLLh4-6dA"), game: ShardGame(.LEGENDS_OF_RUNNETERRA)!, on: .Europe) { (riotActiveShard, errorMsg) in
        if let riotActiveShard = riotActiveShard {
            print("Success!")
        } else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
    }*/
    
    /*league.riotAPI.getAccount(byRiotId: RiotId(gameName: "Sc0ra", tagLine: "EUW"), on: .Europe) { (riotAccount, errorMsg) in
        if let riotAccount = riotAccount {
            print("Success!")
        } else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
    }*/
    
    /*league.riotAPI.getAccount(byPuuid: SummonerPuuid("Mopk9O_5xL3InZzRnXOMW0ay0FDpTcfKwjeWMLDLvVZhNa17JsrjXJt8jRfxq23R_Ct5RHLLh4-6dA"), on: .Europe) { (riotAccount, errorMsg) in
        if let riotAccount = riotAccount {
            print("Success!")
        } else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
    }*/
        
    /*league.lolAPI.getClashPlayers(by: TeamId("7c76ab62-8ad4-43d0-83a0-757e457e2f15"), on: .EUW) { (team, errorMsg) in
           if let team = team {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/
    
    /*league.lolAPI.getClashPlayers(by: SummonerId("l1u59aGq69RycT9It-N-DjdxcVLauJsGX_-LPMauB094Qiw"), on: .EUW) { (players, errorMsg) in
          if let players = players {
              print("Success!")
          } else {
              print("Request failed cause: \(errorMsg ?? "No error description")")
          }
    }*/
    
    /*league.lolAPI.getClashTournament(by: TournamentId(2001), on: .EUW) { (tournament, errorMsg) in
           if let tournament = tournament {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/
    
    /*league.lolAPI.getClashTournaments(on: .EUW) { (tournaments, errorMsg) in
           if let tournaments = tournaments {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/
    
    /*league.lolAPI.getClashPlayers(by: SummonerId("0QgJjfjROo4t7MemZVkbNI0DMeXldcSfGsoWeb0XKWAzaTs"), on: .EUW) { (players, errorMsg) in
           if let players = players {
               print("Success!")
           } else {
               print("Request failed cause: \(errorMsg ?? "No error description")")
           }
    }*/

    
    /*league.lorAPI.getRunneteraLeaderboard(on: .America) { (players, errorMsg) in
        if let players = players {
            print("Success!")
        } else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
    }*/
    

    /*league.tftAPI.getTFTMatch(by: TFTGameId("EUW1_4210310480"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    
    
    /*league.tftAPI.getTFTMatchList(by: SummonerPuuid("8O-V8DGHm3YimSunwz6I6lntBnJVpPexIso6so6DtgXBZMNPnuktCigiLS7AXniMmqJFUvoc3Zrrzw"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    
    
    
    /*league.tftAPI.getTFTSummoner(by: SummonerPuuid("8O-V8DGHm3YimSunwz6I6lntBnJVpPexIso6so6DtgXBZMNPnuktCigiLS7AXniMmqJFUvoc3Zrrzw"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTSummoner(by: AccountId("Tvh3uSJMRiM5crphJJQRvzligztkDSN9QcjsNjimQbDimg"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTSummoner(byName: "Kelmatou", on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTSummoner(by: SummonerId("B5qQc6G9VNAsuHF23OAVtBDZdGnGfVnlFdNBpDAN-MzFHLA"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    
    /*league.tftAPI.getTFTRankedEntries(for: SummonerId("B5qQc6G9VNAsuHF23OAVtBDZdGnGfVnlFdNBpDAN-MzFHLA"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getLeague(by: TFTLeagueId("14e87700-b60d-11e9-8a7f-c81f66db01ef"), on: .EUW) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTChallengerLeague(on: .NA) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTGrandMasterLeague(on: .NA) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTMasterLeague(on: .NA) { (entries, errorMsg) in
        if let entries = entries {
            print("Success!")
        }
        else {
            print("Request failed cause: \(errorMsg ?? "No error description")")
        }
        received = true
    }*/
    /*league.tftAPI.getTFTEntries(on: .NA, division: RankedDivision(tier: tier, divisionRoman: "I"), page: 2) { (entries, errorMsg) in
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

