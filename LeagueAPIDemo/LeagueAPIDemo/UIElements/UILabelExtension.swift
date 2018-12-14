//
//  UILabelExtension.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func setText(_ text: String?) {
        DispatchQueue.main.async {
            self.text = text
        }
    }
}
