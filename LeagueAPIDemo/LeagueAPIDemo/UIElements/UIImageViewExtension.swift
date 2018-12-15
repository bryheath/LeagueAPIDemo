//
//  UIImageViewExtension.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/15/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
