//
//  DataManager.swift
//  App1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Techkids. All rights reserved.
//

import Foundation

class DataManager : NSObject {
    
    static var defaultManager = DataManager()
    
    let kDatabaseName = "pokemon"
    let kDatabaseExtension = "db"
    
    func getDatabaseFolderPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
    }
    
    //1. Copy database
    
    
    func copyDatabaseIfNeed() {
        let bundlePath = Bundle.main.path(forResource: "pokemon", ofType: "db")
        
        let documentPath = self.getDatabaseFolderPath()
        
        print("documentPath         ",documentPath)
        if !FileManager.default.fileExists(atPath: documentPath) {
            do {
                print(bundlePath)
                print(documentPath)
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: documentPath)
            } catch  {
                print(error)
            }
        }
    }
    func loadPokemon() -> [Pokemon] {
        var pokemons : [Pokemon] = []
        let database = FMDatabase(path: self.getDatabaseFolderPath())
        
        database?.open()
        let selectQuery = "SELECT * FROM pokemon"
//        var i = 0;
        do {
            let result =  try database?.executeQuery(selectQuery, values: nil)
            while (result?.next())!{
                let id = result?.int(forColumn: "id")
                let name = result?.string(forColumn: "name")
                let tag = result?.string(forColumn: "tag")
                let gen = result?.int(forColumn: "gen")
                let img = result?.string(forColumn: "img")
                let color = result?.string(forColumn: "color")
                let pokemon = Pokemon(id: Int(id!), name: name!, tag: tag!, gen: Int(gen!), img: img!, color: color!)
                pokemons.append(pokemon)

                
            }
            
            print("Load Successfully")
        } catch  {
            print("Load Fail", error)
        }
        database?.close()
        return pokemons
    }
    
}
