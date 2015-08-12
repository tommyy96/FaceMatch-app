//
//  QuizSelectorViewController.swift
//  App
//
//  Created by Tommy Yang on 7/27/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class QuizSelectorViewController: UIViewController {
    
    @IBOutlet weak var quizSegmentedControl: UISegmentedControl!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var chooseButton: UIButton!
    
    var people: Results<Person>!

    let matchingQuizInstructions = "Multiple Choice Instructions: \nIn this quiz, an image of a person in your list will show up. You have to pick the right name out of several to get a point."
    
    let namingQuizInstructions = "Naming Instructions: \nIn this quiz, an image of a person in your list will show up. You have to enter the person's name into the box to get a point."
    
    override func viewWillAppear(animated: Bool) {        
        self.navigationController?.navigationBarHidden = false
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsTextView.text = matchingQuizInstructions
        let realm = Realm()
        people = realm.objects(Person)
        if people.count <= 1 {
           performSegueWithIdentifier("noPeopleInList", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: AnyObject) {
        switch quizSegmentedControl.selectedSegmentIndex
        {
        case 0:
            instructionsTextView.text = matchingQuizInstructions
        case 1:
            instructionsTextView.text = namingQuizInstructions
        default:
            break
        }
    }
    
    
    @IBAction func chooseButtonPressed(sender: AnyObject) {
        Mixpanel.sharedInstanceWithToken("c712ef1b8da358a2c58d4a5269ca1fb6")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Quiz entered")
        switch quizSegmentedControl.selectedSegmentIndex
        {
        case 0:
            performSegueWithIdentifier("pickerToMatchingQuiz", sender: self)
        case 1:
            performSegueWithIdentifier("pickerToNamingQuiz", sender: self)
        default:
            break;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pickerToMatchingQuiz" {
            let matchingQuizViewController = segue.destinationViewController as! MatchingQuizViewController
            matchingQuizViewController.score = 0
        }
        if segue.identifier == "pickerToNamingQuiz" {
            let namingQuizViewController = segue.destinationViewController as! NamingQuizViewController
            namingQuizViewController.score = 0
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
