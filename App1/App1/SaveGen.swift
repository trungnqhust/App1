//
//  SaveGen.swift
//  App1
//
//  Created by Admin on 11/22/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import Foundation

class SaveGen {
    static var defaultSG = SaveGen()
    var isChoose : [Bool] = [true, true, true, true, true, true]
    func getList() -> [Int] {
        var list : [Int] =  []
        for i in 0..<isChoose.count {
            if isChoose[i] == true {
                list.append(i + 1)
            }
        }
        return list
    }
}
