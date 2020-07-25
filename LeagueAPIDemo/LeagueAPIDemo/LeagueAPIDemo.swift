//
//  LeagueAPIDemo.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import Foundation
import LeagueAPI

public let league: LeagueAPI = LeagueAPI(APIToken: "RGAPI-567337f8-a785-486b-bc7a-edbb795edfda")
public var preferedRegion: Region = Region.EUW
public var preferedWorldRegion: WorldRegion {
    switch preferedRegion {
        case .NA, .BR, .LAN, .LAS, .OCE, .PBE:
            return .America
        case .KR, .JP:
            return .Asia
        case .EUNE, .EUW, .TR, .RU:
            return .Europe
    }
}
public var preferedSummoner: String = "Kelmatou"
