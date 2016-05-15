//
//  ViewController.swift
//  Gigapet
//
//  Created by Tang on 2016/5/14.
//  Copyright © 2016年 Tang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    @IBOutlet var penaltyiImg: UIImageView! //typo
    @IBOutlet var penalty2Img: UIImageView!
    @IBOutlet var penalty3Img: UIImageView!
    @IBOutlet var restartBtn: UIButton!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    // use similar name for autocomplete search
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penaltyiImg.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        
        
        // selector的函數名稱要加冒號，這表示該函數有一個或一個以上的參數
        // 而NSNotificationCenter會傳入一個NSNotification Object，所以需要冒號
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        // 雖然確定有資料，但讀取加進來的資料可能會抓不到，所以要用do catch
        do {
            // 拆成三行，但也可以只用一行做
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")! // 只是從bundle開始找的路徑
            let url = NSURL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            // 一行作法，path 需要 explicitly unwarp
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))

            musicPlayer.prepareToPlay()
            musicPlayer.play()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxBite.prepareToPlay()
            
            
        } catch let err as NSError {
            print (err.debugDescription)
        }
        
        
        startTimer()
    }
    
    
    func itemDroppedOnCharacter(notif: AnyObject) {

        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        // stop the timer
        if timer != nil {
            timer.invalidate()
        }
        // reset the timer
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }

    
    func changeGameState() {
        
        if !monsterHappy {
            
            penalties++
            sfxSkull.play()
            
            if penalties == 1 {
                penaltyiImg.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penaltyiImg.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
            
        }
        
        let rand = arc4random_uniform(2) // 0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
    }
    
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        restartBtn.hidden = false
        foodImg.alpha = DIM_ALPHA
        heartImg.alpha = DIM_ALPHA
    }
    
    @IBAction func onRestartTapped(sender: AnyObject) {
        
        penalties = 0
        viewDidLoad()
        restartBtn.hidden = true
        monsterImg.playIdleAnimation()
        
    }
    
    

}

