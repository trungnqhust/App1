//
//  Gen.swift
//  App1
//
//  Created by Admin on 11/21/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import Foundation

class Gen {
    var amount : Int!
    var startIndex : Int!
    var remain : Int!
    init(amount : Int, startIndex : Int, remain : Int) {
        self.amount = amount
        self.startIndex = startIndex
        self.remain = remain
    }
    func decreaseRemain() {
        if self.remain > 0 {
            self.remain = self.remain - 1
        }   else    {
            self.remain = self.amount
        }
    }
}
