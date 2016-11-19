//
//  QTProgressBar.swift
//  App1
//
//  Created by Admin on 11/17/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import UIKit

@IBDesignable
class QTProgressBar: UIView {


//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    @IBInspectable var degree : CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var timeBackgroundColor: UIColor?
    var timeColor : UIColor?
    
    func setColor(timeBackgroundColor: UIColor, timeColor : UIColor){
        self.timeColor = timeColor
        self.timeBackgroundColor = timeBackgroundColor
    }
    
    func setDegree(degree : CGFloat) {
        self.degree = degree
    }
    
    override func draw(_ rect: CGRect) {
//         Drawing code
        
        let radius = self.frame.width / 2
        let center = CGPoint(x: radius, y :radius)
        
        let circleBackground = UIBezierPath(arcCenter: center, radius: self.frame.width/2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        //        UIColor.red.setFill()
        self.timeBackgroundColor?.withAlphaComponent(1).setFill()
        
        circleBackground.fill()
        
        let circleTime = UIBezierPath()
        
        circleTime.addArc(withCenter: center, radius: self.frame.width/2, startAngle:  CGFloat(-M_PI_2), endAngle:degree * CGFloat(M_PI) / 180 + CGFloat(-M_PI_2), clockwise: false)
        circleTime.addLine(to: center)
        circleTime.addLine(to: CGPoint(x: radius, y: 0))
//        UIColor.blue.set()
//        UIColor.red.setFill()
        self.timeColor?.withAlphaComponent(1).setFill()
        circleTime.fill()
        
    }


}
