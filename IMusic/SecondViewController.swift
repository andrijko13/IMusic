//
//  SecondViewController.swift
//  IMusic
//
//  Created by Andriy Suden on 6/19/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UISearchBarDelegate, UIWebViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var backgroundView: UIView! = nil
    
    var currentSong: String = ""
    
    @IBAction func downloadMp3Clicked(_ sender: Any) {
        IMDownloader.sharedInstance.downloadSong(fromURL: searchBar.text!, withTitle: currentSong)
        let url = URL(string: "https://www.youtube.com/")
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                
                guard let strongSelf = self else { return }
                
                if error == nil {
                    
                    strongSelf.webView.loadRequest(request)
                    
                } else {
                    
                    print("ERROR: \(error)")
                    
                }
            }
            
            task.resume()
        }
    }
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        let youtubeLink: String = searchBar.text!
        let downloader: IMDownloader = IMDownloader.sharedInstance
        
        let data: Dictionary<String, Any>? = downloader.getSongData(fromURL: "https://www.youtubeinmp3.com/fetch/?format=JSON&video=\(youtubeLink)")
        let component = (youtubeLink as NSString).lastPathComponent
        var identity: String = ""
        
        if let range = component.range(of: "=") {
            identity = component.substring(from: range.upperBound)
        } else {
            identity = component
        }
        
        let url = URL(string: "https://www.yt-download.org/api-console/audio/\(identity)")
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                
                guard let strongSelf = self else { return }
                
                if error == nil {
                    
                    strongSelf.webView.loadRequest(request)
                    
                } else {
                    
                    print("ERROR: \(error)")
                    
                }
            }
            
            task.resume()
        }

        var title = ""
        if let strongData = data {
            currentSong = strongData["title"] as! String
        }
//        downloader.downloadSong(fromURL: link!, withTitle: title!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        webView.isHidden = true
        webView.scrollView.bounces = false
        spinner.activityIndicatorViewStyle = .white
        webView.delegate = self
        
        setStatusBarColor(.lightGray)
        searchBar.isTranslucent = false
        searchBar.tintColor = Styler.main.colorForKey(.lightGray)
        searchBar.barTintColor = Styler.main.colorForKey(.tabBarGray)
        
        backgroundView = UIView(frame: webView.frame)
        backgroundView.center = webView.center
        backgroundView.backgroundColor = UIColor.darkGray
        self.view.addSubview(backgroundView)
        self.view.bringSubview(toFront: spinner)
        spinner.activityIndicatorViewStyle = .white
        spinner.color = UIColor.white
        spinner.startAnimating()
        
        let url = URL(string: "https://www.youtube.com/")
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { [weak self] (data, response, error) in
                
                guard let strongSelf = self else { return }
                
                if error == nil {
                    
                    strongSelf.webView.loadRequest(request)
                    
                } else {
                    
                    print("ERROR: \(error)")
                    
                }
            }
            
            task.resume()
        }
        
        webView.isHidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        backgroundView.isHidden = false
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        backgroundView.isHidden = true
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

