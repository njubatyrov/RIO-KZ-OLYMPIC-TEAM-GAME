//
//  MainViewController.swift
//  Rio
//
//  Created by Nursultan on 8/5/16.
//  Copyright © 2016 Nursultan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {


    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var bestScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        guard let recordScore = defaults.valueForKey("recordResult") as? Int else {
            return
        }
        
        self.bestScoreLabel.text = "\(recordScore)"
    
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        imageViewBackground.image = UIImage(named: "background")
        imageViewBackground.alpha = 0.8
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageViewBackground)
        
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.whiteColor().CGColor
        startButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startGameButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("PlayGameSegue", sender: nil)
    }
    
}
