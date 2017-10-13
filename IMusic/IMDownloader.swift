//
//  IMDownloader.swift
//  IMusic
//
//  Created by Andriy Suden on 6/19/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit
import Dispatch

class IMDownloader: NSObject, NSURLConnectionDelegate {
    static let sharedInstance = IMDownloader()
    private override init() { }
    
    func getSongData(fromURL urlPath: String) -> Dictionary<String, Any>? {
        let url: URL = URL(string: urlPath)!
        let request1: URLRequest = URLRequest(url: url)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
        
        do{
            let dataVal = try NSURLConnection.sendSynchronousRequest(request1, returning: response)
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: dataVal, options: []) as? Dictionary<String, Any> {
                    print("Synchronous\(jsonResult)")
                    return jsonResult
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            return nil
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func downloadSong(fromURL urlPath: String, withTitle title: String) {
        let url: URL = URL(string: urlPath)!
        let request1: URLRequest = URLRequest(url: url)
        let queue: OperationQueue = OperationQueue()
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsdir = paths[0]
        
        let songTitle = "\(docsdir)/music/\(title).mp3"
        let fileUrl = URL(fileURLWithPath: songTitle)
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler: {
            (response: URLResponse?, data: Data?, error: Error?) -> Void in
            
            do {
                do {
                    print("Data received: \(data?.count)")
                    try data?.write(to: fileUrl)
                } catch let error2 as NSError {
                    print("Failed to write song \(error2.localizedDescription)!")
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        
        MusicCollection.sharedInstance.reload()
    }
}
