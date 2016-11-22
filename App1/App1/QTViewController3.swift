//
//  QTViewController3.swift
//  App1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import UIKit

class QTViewController3: UIViewController {
    
    let kAlpha : CGFloat =  0.5
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchGenBtn(_ sender: AnyObject) {
        sender.setAlpha(1 + kAlpha - sender.alpha)
        if sender.alpha == kAlpha {
            SaveGen.defaultSG.isChoose[sender.tag] = false
        }   else    {
            SaveGen.defaultSG.isChoose[sender.tag] = true
        }
    }


    @IBAction func invokeBack(_ sender: AnyObject) {
        for i in SaveGen.defaultSG.isChoose {
            if i == true {
                self.navigationController?.popViewController(animated: true)
                break
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
