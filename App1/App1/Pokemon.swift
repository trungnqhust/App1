//
//  Pokemon.swift
//  App1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import Foundation

class Pokemon {
    private var id : Int = -1
    private var name : String = ""
    private var tag : String = ""
    private var gen : Int = -1
    private var color : String = ""
    private var img : String = ""
    
    init(id : Int, name : String, tag : String, gen : Int, img : String, color : String) {
        self.color = color
        self.gen = gen
        self.id = id
        self.img = img
        self.name = name
        self.tag = tag
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getColor() -> String {
        return self.color
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getImage() -> String {
        return self.img
    }
    
    func getGen() -> Int {
        return self.gen
    }
    
    func getTag() -> String {
        return self.tag
    }
}
