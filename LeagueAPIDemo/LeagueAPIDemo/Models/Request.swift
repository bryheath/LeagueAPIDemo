//
//  Request.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

enum RequestTypes: String {
    case FeaturedGames
    case SummonerByName
    case LiveGame
    case MatchHistory
    case ChampionRotation
    case ChampionInfo
}

class Request {
    
    public var title: String {
        return self.type.rawValue
    }
    public var type: RequestTypes
    public var image: UIImage?
    
    public init(_ type: RequestTypes, image: UIImage?) {
        self.type = type
        self.image = image
    }
}
