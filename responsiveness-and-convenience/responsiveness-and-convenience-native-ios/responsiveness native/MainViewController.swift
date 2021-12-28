//
//  ViewController.swift
//  responsiveness native
//
//  Created by Iman Jamali on 2021-10-02.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
    
    @IBAction func buttonPressed() {
        print("start navigating to pageA", NSDate().timeIntervalSince1970 * 1000)
        self.performSegue(withIdentifier: "goToB", sender: self)
    }
}

