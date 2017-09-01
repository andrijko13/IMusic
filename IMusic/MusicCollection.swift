//
//  MusicCollection.swift
//  IMusic
//
//  Created by Andriy Suden on 6/19/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit

class Song: NSObject {
    
}

class MusicCollection: NSObject {

    static let sharedInstance = MusicCollection()
    private var songs: [String] = []
    
    private override init() {
        super.init()
        songs = fetchAll()
    }
    
    func reload() {
        songs = fetchAll()
    }

    func getAll() -> [String] {
        reload()
        return songs
    }
    
    private func fetchAll() -> [String] {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsdir = paths[0]
        
        let dir: String = "\(docsdir)/music/"
        
        let fileManager = FileManager.default
        let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: dir)!
        
        var result: [String] = [String]()
        
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("mp3") { // checks the extension
                result.append(element)
            }
        }
        
        return result.sorted()
    }
    
}
