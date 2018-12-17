//
//  UITableViewExtension.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/17/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func reload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
