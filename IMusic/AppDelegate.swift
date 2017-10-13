//
//  AppDelegate.swift
//  IMusic
//
//  Created by Andriy Suden on 6/19/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mp3player: MP3Player! = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.tintColor = Styler.main.colorForKey(.errorRed)
        
        UIApplication.shared.statusBarStyle = .lightContent
                
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsdir = paths[0]
        
        let songTitle = URL(fileURLWithPath: "\(docsdir)/music/", isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(at: songTitle, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        } catch let error as NSError {
            print(error.description)
        }
        
        MusicCollection.sharedInstance.reload()
        mp3player = MP3Player()
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget(self, action:#selector(playNext))
        
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget(self, action: #selector(playPrevious))
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget(self, action: #selector(pause))
        
        commandCenter.stopCommand.isEnabled = true
        commandCenter.stopCommand.addTarget(self, action: #selector(stop))
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(play))
        
        commandCenter.togglePlayPauseCommand.isEnabled = true
        commandCenter.togglePlayPauseCommand.addTarget(self, action: #selector(playPause))

        // Override point for customization after application launch.
        return true
    }
    
    func play() {
        mp3player.play()
    }
    
    func playPause() {
        if mp3player.player?.isPlaying == true {
            mp3player.pause()
        } else if mp3player.player?.isPlaying == false {
            mp3player.play()
        }
    }
    
    func playNext() {
        mp3player.nextSong(songFinishedPlaying: true)
    }
    
    func playPrevious() {
        if mp3player.getCurrentTimeInSeconds() < 2 {
            mp3player.currentSong()
        } else {
            mp3player.previousSong()
        }
    }
    
    func pause() {
        mp3player.pause()
    }
    
    func stop() {
        mp3player.stop()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

