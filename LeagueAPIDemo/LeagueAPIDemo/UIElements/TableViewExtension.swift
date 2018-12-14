//
//  TableViewExtension.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/14/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Offset from top (when tableview or safe area if modifying inset)
    var topOffset: CGFloat {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets.top
        }
        else {
            return self.contentInset.top
        }
    }
}
