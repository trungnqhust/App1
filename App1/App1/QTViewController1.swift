//
//  QTViewController1.swift
//  App1
//
//  Created by Admin on 11/21/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import UIKit

class QTViewController1: UIViewController {
    
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var currentScore: UILabel!

    var score = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
//        print("start delay")
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.updateHighScore()
        self.currentScore.text = "\(self.score)"
        print("score trong vc1:\(self.score)")
    }
    
    func updateHighScore() {
        if (UserDefaults.standard.value(forKey: "score") != nil){
            self.score = UserDefaults.standard.value(forKey: "score") as! Int
        } else {
            self.score = 0
        }
        if ( UserDefaults.standard.value(forKey: "highscore") == nil) {
            UserDefaults.standard.set(score, forKey: "highscore")
        } else {
            let highscore = UserDefaults.standard.value(forKey: "highscore") as! Int
            if score > highscore {
                UserDefaults.standard.set(score, forKey: "highscore")
                highScore.text = "NEW HIGH SCORE: \(self.score)"
            } else {
                highScore.text = "HIGH SCORE: \(highscore)"
                
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
