//
//  MatchTableViewCell.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/22/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var championSquare: UIImageView!
    @IBOutlet weak var mapName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchDuration: UILabel!
    @IBOutlet weak var spell1Square: UIImageView!
    @IBOutlet weak var spell2Square: UIImageView!
}
