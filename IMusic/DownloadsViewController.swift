//
//  DownloadsViewController.swift
//  IMusic
//
//  Created by Andriy Suden on 6/19/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit
import MediaPlayer

class DownloadsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var songs: [String] = [String]()
    var mp3player: MP3Player! = nil
    
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        songsTableView.dataSource = self
        songsTableView.delegate = self
        setStatusBarColor(.lightGray)
        navBar.isTranslucent = false
        navBar.barTintColor = Styler.main.colorForKey(.lightGray)
        searchBar.barTintColor = Styler.main.colorForKey(.tabBarGray)
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        mp3player = mainDelegate.mp3player
        
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
                
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        songs = MusicCollection.sharedInstance.getAll()
        songsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // did select
        mp3player.play(song: songs[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "SongCell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let docsdir = paths[0]
            let songName = MusicCollection.sharedInstance.getAll()[indexPath.row]
            
            let songPath = "\(docsdir)/music/\(songName)"
            let fileManager = FileManager.default
            
            do {
                try fileManager.removeItem(atPath: songPath)
            }
            catch let error as NSError {
                print("Error when deletinf file: \(error)")
            }
            
            songs = MusicCollection.sharedInstance.getAll()
            songsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
