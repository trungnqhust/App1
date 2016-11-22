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
    
    @IBOutlet weak var clockPB: RPCircularProgress!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var answerAbtn: UIButton!
    
    @IBOutlet weak var answerBbtn: UIButton!
    
    @IBOutlet weak var answerCbtn: UIButton!
    
    @IBOutlet weak var answerDbtn: UIButton!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var imagePokemon: UIImageView!
    
    @IBOutlet var backgroundView: UIView!
    
    var pokemons : [Pokemon] = []
    var answers = ["Zekrom","chemande", "pokemon", "Other"]
    var rightAnswer = "Zekrom"
    var imageName = "Zekrom"
    var idNumber = "001"
    var backgroundColor : UIColor!
    
    var gens : [Gen] = []
    let maxGen = 6
    var pokPosition : [Int] = []
    
    var tabAnswerEnable : Bool!
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        DataManager.defaultManager.copyDatabaseIfNeed()
        pokemons = DataManager.defaultManager.loadPokemon()
        self.setupInit()
        self.selectPokemon(genList: SaveGen.defaultSG.getList())
        print("cac pokemon duoc chon trong cac gen: \(SaveGen.defaultSG.getList())")
        self.setUI()
        self.playTime(time : 20)
    }
    
    
    
    func setupInit() {
        self.getGenInformation()
        self.clockPB.thicknessRatio = 0.5
        scoreLabel.text = "0"
        score = 0
    }
    
    func getGenInformation() {
        let startIndex : [Int] = [0,151,251,392,512,674,745]    //maxGen + 1 = 7 phan tu
        // khoi tao cac Gen
        gens.append(Gen(amount: 0, startIndex: 0, remain: 0))
        for i in 1..<maxGen+1{
            gens.append(Gen(amount: startIndex[i] - startIndex[i-1], startIndex: startIndex[i-1], remain: startIndex[i] - startIndex[i-1]))
        }
        
        // gan tam thoi cac pokemon vao mang pokPosition
        for i in 0..<startIndex[maxGen]{
            pokPosition.append(i)
        }
        // gen1 : 0 - 150        // gen2 : 151 - 250        // gen3 : 251 - 391        // gen4 : 392 - 511        // gen5 : 512 - 673        // gen6 : 674 - 746
    }
    
    // MARK: for a query
    func selectPokemon(genList : [Int]) {
        // chon 1 gen bat ki trong so cac gen nam trong genList
        let genChose = genList[random(max: genList.count)]
        
        // chon 1 vi tri bat ki trong gen da chon
        let pokPosInGen = random(max: gens[genChose].amount)
        
        // lay thong tin cua pokemon tuong ung
        loadData(pokemon: pokemons[gens[genChose].startIndex + pokPosInGen])
        
        // dua vi tri cua pokemon duoc chon ve cuoi va giam remain cua gen tuong ung
        swapPokPosition(i: gens[genChose].startIndex + pokPosInGen, j: gens[genChose].startIndex + gens[genChose].amount)
        gens[genChose].decreaseRemain()
        
    }
    
    func loadData(pokemon : Pokemon) {
        // ten
        answers[0] = pokemon.getName()
        
        // color
        let colorName = pokemon.getColor().replacingOccurrences(of: "#", with: "").lowercased()
            //pokemon.getColor().replacingOccurrences(of: "#", with: "").lowercased()
//        print("colorname = \(colorName)")
//        
//        let colorCode = UInt8(strtoul(colorName, nil, 16))
//        print("colorCode = \(colorCode)")
        backgroundColor = UIColor(hexString: colorName)
        
        rightAnswer = pokemon.getName()
        imageName = pokemon.getImage()
        idNumber = pokemon.getId().description
        
        
        // add 3 other different wrong answer
        var answerHad = 1
        while answerHad < 4 {
            let i = random(max: maxGen) + 1
            let r = random(max: gens[i].amount)
            let newName = pokemons[pokPosition[gens[i].startIndex + r]].getName()
            var add = true
            for j in 0..<answerHad {
                if answers[j] == newName {
                    add = false
                    break
                }
            }
            if  add == true {
                answers[answerHad] = newName
                answerHad += 1
            }
        }
        
        
        // hoan vi vi tri dap an
        let rand = random(max: 4)
        let temp = answers[0]
        answers[0] = answers[rand]
        answers[rand] = temp
        
    }
    
    // MARK: SetUI
    func setUI() {
        tabAnswerEnable = true
        setButtonTitle(names: answers)
        setImagePokemon(name: imageName)
        
        idLabel.isHidden = true
        backgroundView.backgroundColor = backgroundColor
    }
    
    func setButtonTitle(names : [String]) {

        answerAbtn.setTitle(names[0], for: .normal)
        answerBbtn.setTitle(names[1], for: .normal)
        answerCbtn.setTitle(names[2], for: .normal)
        answerDbtn.setTitle(names[3], for: .normal)
        answerAbtn.backgroundColor = UIColor.white
        answerBbtn.backgroundColor = UIColor.white
        answerCbtn.backgroundColor = UIColor.white
        answerDbtn.backgroundColor = UIColor.white
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
        
        let button = sender as! UIButton
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
                print("setted green")
            }
        }
        
        
        idLabel.text = "#" + idNumber + " " + rightAnswer
        idLabel.isHidden = false
        

        delay(0.3) { 
            self.selectPokemon(genList: [1])
            self.setUI()

        }
        
    }
    
    //MARK : BACK
    
    @IBAction func invokeBack(_ sender: AnyObject) {
        print("click back")
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK : playtime
    func playTime(time : Int) {
        DispatchQueue.main.async {
            self.clockPB.updateProgress(1, animated: true, initialDelay: 0, duration: CFTimeInterval(time), completion: {
                UserDefaults.standard.set(self.score, forKey: "score")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.navigationController?.popViewController(animated: true)
                    
//                    let VC1 = self.navigationController?.topViewController as! QTViewController1
//                    VC1.score = self.score
//                    print("score = \(self.score)")
                })
                
            })
        }
    }
    // MARK: Extensions
    
    func random(max : Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    func swapPokPosition(i : Int, j : Int) {
        let temp = pokPosition[i]
        pokPosition[i] = pokPosition[j]
        pokPosition[j] = temp
    }
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
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
