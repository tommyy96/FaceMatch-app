//
//  AfterQuestionViewController.swift
//  App
//
//  Created by Tommy Yang on 8/4/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit

class AfterQuestionViewController: UIViewController {

    @IBOutlet weak var rightWrongLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var rightWrong: String! = ""
    var quizType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightWrongLabel.text = rightWrong
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextQuestionButtonPressed(sender: AnyObject) {
        if quizType == "matching" {
            performSegueWithIdentifier("afterQuestionToMatching", sender: self)
        }
        else if quizType == "naming" {
            performSegueWithIdentifier("afterQuestionToNaming", sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
