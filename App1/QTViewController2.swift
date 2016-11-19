//
//  QTViewController2.swift
//  App1
//
//  Created by Admin on 11/17/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import UIKit
import SpriteKit

class QTViewController2: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerAbtn: UIButton!
    
    @IBOutlet weak var answerBbtn: UIButton!
    
    @IBOutlet weak var answerCbtn: UIButton!
    
    @IBOutlet weak var answerDbtn: UIButton!
    
    @IBOutlet weak var clockPB: QTProgressBar!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var imagePokemon: UIImageView!
    
    var answers = ["Zekrom","chemande", "pokemon", "Other"]
    var rightAnswer = "Zekrom"
    var imageName = "Zekrom"
    var idNumber = "001"
    
    var tabAnswerEnable : Bool!
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setUI()
        scoreLabel.text = "0"
        score = 0
        tabAnswerEnable = true
        clockPB.setDegree(degree: 90) // degree : 0 -> 360
        
    }
    
    
    
    @IBAction func invokeBack(_ sender: AnyObject) {
        print("click back")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: SetUI
    func setUI() {
        clockPB.setColor(timeBackgroundColor: UIColor.white, timeColor: UIColor.red)
        
        setButtonTitle(names: answers)
        setImagePokemon(name: imageName)
        
        idLabel.isHidden = true
        
    }
    
    func setButtonTitle(names : [String]) {
        answerAbtn.setTitle(names[0], for: .normal)
        answerBbtn.setTitle(names[1], for: .normal)
        answerCbtn.setTitle(names[2], for: .normal)
        answerDbtn.setTitle(names[3], for: .normal)
    }
    
    func setImagePokemon(name : String) {
        self.imagePokemon.tintColor = UIColor.black
        imagePokemon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
    }
    
    //MARK: tapChooseAnswer
    @IBAction func tabAnswer(_ sender: AnyObject) {
        if tabAnswerEnable == false {
                return
        }
        
        tabAnswerEnable = false
        imagePokemon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        
        let button = self.view.viewWithTag(sender.tag) as! UIButton
        if button.titleLabel?.text != rightAnswer {
            button.backgroundColor = UIColor.red
        }   else    {
            score += 1
            scoreLabel.text = score.description
        }
        
        let btns = [answerAbtn,answerBbtn,answerCbtn,answerDbtn]
        for btn in btns {
            if btn?.titleLabel?.text == rightAnswer {
                btn?.backgroundColor = UIColor.green
            }
        }
        
        idLabel.text = "#" + idNumber + " " + rightAnswer
        idLabel.isHidden = false
        

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
