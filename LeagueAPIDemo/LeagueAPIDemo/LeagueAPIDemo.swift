//
//  LeagueAPIDemo.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import Foundation
import LeagueAPI

//public let league: LeagueAPI = LeagueAPI(APIToken: "RGAPI-567337f8-a785-486b-bc7a-edbb795edfda")
public let league:League_API = League_API(APIToken: "RGAPI-0d89fa64-c77f-4a5f-bb9e-510a95fa1e38")
//public var preferedRegion: Region = Region.EUW
public var preferredRegion: Region = Region.NA
public var preferredWorldRegion: WorldRegion {
    switch preferredRegion {
        case .NA, .BR, .LAN, .LAS, .OCE, .PBE:
            return .America
        case .KR, .JP:
            return .Asia
        case .EUNE, .EUW, .TR, .RU:
            return .Europe
        default:
            return .America
    }
}
//public var preferedSummoner: String = "Kelmatou"
public var preferredSummoner: String = "SunraiRW"
