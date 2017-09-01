//
//  MainTabBarController.swift
//  IMusic
//
//  Created by Andriy Suden on 6/19/17.
//  Copyright © 2017 DropGeeks. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.items?[0].title = "My Playlists"
        self.tabBar.items?[1].title = "Search"
        self.tabBar.items?[2].title = "My Downloads"
        
        self.tabBar.tintColor = Styler.main.colorForKey(.lightBlue)
        self.tabBar.barTintColor = Styler.main.colorForKey(.tabBarGray)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
