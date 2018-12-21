//
//  UITextViewExtension.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 12/21/18.
//  Copyright © 2018 Antoine Clop. All rights reserved.
//

import UIKit

extension UITextView {
    
    public func setText(_ text: String?) {
        DispatchQueue.main.async {
            self.text = text
        }
    }
}
