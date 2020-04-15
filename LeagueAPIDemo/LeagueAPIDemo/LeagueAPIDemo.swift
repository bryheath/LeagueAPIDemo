//
//  LeagueAPIDemo.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import Foundation
import LeagueAPI

public let league: LeagueAPI = LeagueAPI(APIToken: "RGAPI-eac8956b-76d1-4edd-9638-8f22e18c0870")
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
