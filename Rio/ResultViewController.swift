//
//  ResultViewController.swift
//  Rio
//
//  Created by Nursultan on 8/6/16.
//  Copyright © 2016 Nursultan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    var documentController: UIDocumentInteractionController!
    var score: Int = 0
    var bestScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
        self.scoreLabel.text = "\(score)"
        //print(score)
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var recordScore = defaults.valueForKey("recordResult") as? Int
        
        if recordScore != nil {
            if score > recordScore {
                recordScore = score
            }
        } else {
            recordScore = score
        }
        
        defaults.setInteger(recordScore!, forKey: "recordResult")
        
        self.bestScoreLabel.text = "\(recordScore!)"
    }
    
    
    @IBAction func shareButtonPressed(sender: UIButton) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        var sourceImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let instagramURL = NSURL(string: "instagram://app")
        
        if (UIApplication.sharedApplication().canOpenURL(instagramURL!)) {
            
        let imageData = UIImageJPEGRepresentation(sourceImage, 100)
        
        let captionString = "caption"
        
        let writePath = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("instagram.igo")
        if imageData?.writeToFile(writePath, atomically: true) == false {
            
            return
            
        } else {
            let fileURL = NSURL(fileURLWithPath: writePath)
            
            self.documentController = UIDocumentInteractionController(URL: fileURL)
            
            self.documentController.delegate = self
            
            self.documentController.UTI = "com.instagram.exlusivegram"
            
            self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstagramCaption")
            self.documentController.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
            
        }
        
    } else {
    print(" Instagram isn't installed ")
    }
    }
    
    @IBAction func startAgainButtonPressed(sender: UIButton) {
//        self.dismissViewControllerAnimated(false, completion: nil)
        self.performSegueWithIdentifier("AgainSegue", sender: nil)
    }
    
    func initUI() {
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        imageViewBackground.image = UIImage(named: "background")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageViewBackground)
    }
}
