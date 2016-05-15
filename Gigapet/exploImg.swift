//
//  exploImg.swift
//  Gigapet
//
//  Created by Tang on 2016/5/16.
//  Copyright © 2016年 Tang. All rights reserved.
//

import Foundation
import UIKit

class ExploImg: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

        
    }
    
    func playExploAnimation() {
        
        self.image = UIImage(named: "explo (1).png")
        
        var imgArr = [UIImage]()
        
        for var x = 1; x <= 11; x++ {
            let img = UIImage(named: "explo (\(x)).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 1.5
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    func playReverseExploAnimation() {
        
        self.image = UIImage(named: "explo (11).png")
        
        var imgArr = [UIImage]()
        
        for var x = 11; x >= 1; x-- {
            let img = UIImage(named: "explo (\(x)).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 1.5
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}