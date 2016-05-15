//
//  DragImg.swift
//  Gigapet
//
//  Created by Tang on 2016/5/15.
//  Copyright © 2016年 Tang. All rights reserved.
//

import Foundation
import UIKit


class DragImg: UIImageView{
    
    var originalPosition: CGPoint!
    var dropTarget: UIView? // 用UIView，以後可以用其子類別，方便OOP
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecode: NSCoder){
        super.init(coder: aDecode)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
 
        if let touch = touches.first, let target = dropTarget {
            
            let position = touch.locationInView(self.superview)
            
            if CGRectContainsPoint(target.frame, position) { // 檢查前面的rect是否包含後面的point
                
                
//                var notif = NSNotification(name: "onTargetDropped", object: nil)
                // 等同下面name放notif，下面只是one line code
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
                
            }
            
        }
        
        self.center = originalPosition
    }
    
}