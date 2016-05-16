//
//  MonsterImg.swift
//  Gigapet
//
//  Created by Tang on 2016/5/15.
//  Copyright © 2016年 Tang. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        playIdleAnimation()
        
    }
    
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        
        var imgArr = [UIImage]()
        
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 // infinite loop
        self.startAnimating()
    }
    
    func playBigIdleAnimation() {
        self.image = UIImage(named: "blue_idle (1).png")
        
        var imgArr = [UIImage]()
        
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "blue_idle (\(x)).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 // infinite loop
        self.startAnimating()

    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imgArr = [UIImage]()
        
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "dead\(x).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()

    }
    
}