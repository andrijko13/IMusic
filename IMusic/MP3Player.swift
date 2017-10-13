//
//  MP3Player.swift
//  IMusic
//
//  Created by Andriy Suden on 9/1/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit
import AVFoundation

class MP3Player: NSObject, AVAudioPlayerDelegate {
    var player:AVAudioPlayer?
    var currentTrackIndex = 0
    var tracks:[String] = [String]()
    
    override init(){
        tracks = MusicCollection.sharedInstance.getAll()
        super.init()
        queueTrack()
    }

    func queueTrack(){
        if (player != nil) {
            player = nil
        }

        tracks = MusicCollection.sharedInstance.getAll()
        guard tracks.count > 0 else { return }

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsdir = paths[0]

        let songPath = "\(docsdir)/music/\(tracks[currentTrackIndex])"
        let url = NSURL.fileURL(withPath: songPath)

        do {
            try player = AVAudioPlayer(contentsOf: url)

            player?.delegate = self
            player?.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func play() {
        guard tracks.count > 0 else { return }
        if player?.isPlaying == false {
            player?.play()
        } else {
            stop()
            player?.play()
        }
    }
    
    func play(song: String) {
        if let index = MusicCollection.sharedInstance.getAll().index(of: song) {
            currentTrackIndex = index
            queueTrack()
            play()
        }
    }
    
    func stop(){
        if player?.isPlaying == true {
            player?.stop()
            player?.currentTime = 0
        }
    }
    
    func pause(){
        if player?.isPlaying == true{
            player?.pause()
        }
    }
    
    func nextSong(songFinishedPlaying:Bool){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        currentTrackIndex += 1
        if currentTrackIndex >= tracks.count {
            currentTrackIndex = 0
        }
        queueTrack()
        if playerWasPlaying || songFinishedPlaying {
            player?.play()
        }
    }
    
    func previousSong(){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        currentTrackIndex -= 1
        if currentTrackIndex < 0 {
            currentTrackIndex = tracks.count - 1
        }
        
        queueTrack()
        if playerWasPlaying {
            player?.play()
        }
    }
    
    func currentSong(){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        queueTrack()
        if playerWasPlaying {
            player?.play()
        }
    }

    
    func getCurrentTrackName() -> String {
        let trackName = tracks[currentTrackIndex]
        return trackName
    }
    
    func getCurrentTimeAsString() -> String {
        var seconds = 0
        var minutes = 0
        if let time = player?.currentTime {
            seconds = Int(time) % 60
            minutes = (Int(time) / 60) % 60
        }
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    func getCurrentTimeInSeconds() -> Int {
        var seconds = 0
        if let time = player?.currentTime {
            seconds = Int(time)
        }
        return seconds
    }
    
    func getProgress()->Float{
        var theCurrentTime = 0.0
        var theCurrentDuration = 0.0
        if let currentTime = player?.currentTime, let duration = player?.duration {
            theCurrentTime = currentTime
            theCurrentDuration = duration
        }
        return Float(theCurrentTime / theCurrentDuration)
    }
    
    func setVolume(volume:Float){
        player?.volume = volume
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            nextSong(songFinishedPlaying: true)
        }
    }
}
