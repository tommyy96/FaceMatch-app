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
    @IBOutlet weak var pointsLabel: UILabel!
    
    var score: Int!
    var rightWrong: String! = ""
    var quizType: String!
    var lastQuestion: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        rightWrongLabel.text = rightWrong
        pointsLabel.text = "Points: \(score)"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextQuestionButtonPressed(sender: AnyObject) {
        if lastQuestion {
            performSegueWithIdentifier("lastQuestionToFinish", sender: self)
        }
        else {
            if quizType == "matching" {
                performSegueWithIdentifier("afterQuestionToMatching", sender: self)
            }
            else if quizType == "naming" {
                performSegueWithIdentifier("afterQuestionToNaming", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "lastQuestionToFinish" {
            let finishedQuizViewContoller = segue.destinationViewController as! FinishedQuizViewController
            finishedQuizViewContoller.score = score
        }
        if segue.identifier == "afterQuestionToMatching" {
            let matchingQuizViewController = segue.destinationViewController as! MatchingQuizViewController
            matchingQuizViewController.score = score
        }
        if segue.identifier == "afterQuestionToNaming" {
            let namingQuizViewController = segue.destinationViewController as! NamingQuizViewController
            namingQuizViewController.score = score
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
