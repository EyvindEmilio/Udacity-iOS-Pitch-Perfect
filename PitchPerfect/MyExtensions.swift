//
//  MyEstensions.swift
//  PitchPerfect
//
//  Created by Eyvind on 17/3/22.
//

import UIKit

extension UIControl{
    func setCustomEnable(_ enabled:Bool){
        self.isEnabled = enabled
        self.alpha = enabled ? 1.0 : 0.8
    }
}
