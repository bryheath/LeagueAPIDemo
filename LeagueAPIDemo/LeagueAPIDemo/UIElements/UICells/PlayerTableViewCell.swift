//
//  PlayerTableViewCell.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/17/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import Foundation

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var championSquare: UIImageView!
    @IBOutlet weak var summonerSquare: UIImageView!
    @IBOutlet weak var rankedSquare: UIImageView!
    @IBOutlet weak var summonerName: UILabel!
    @IBOutlet weak var masteryLabel: UILabel!
    
}
