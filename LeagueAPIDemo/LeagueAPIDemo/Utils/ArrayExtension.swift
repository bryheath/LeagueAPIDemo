//
//  ArrayExtension.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/17/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import Foundation

extension Array {
    
    public func element(at index: Int) -> Element? {
        if self.count > index {
            return self[index]
        }
        return nil
    }
}
