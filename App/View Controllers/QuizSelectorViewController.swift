//
//  QuizSelectorViewController.swift
//  App
//
//  Created by Tommy Yang on 7/27/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift

class QuizSelectorViewController: UIViewController {
    
    @IBOutlet weak var quizSegmentedControl: UISegmentedControl!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var chooseButton: UIButton!
    
    var people: Results<Person>!

    let matchingQuizInstructions = "Matching Quiz Instructions: \nIn this quiz, an image of a person in your list will show up. You have to pick the right name out of several to get a point."
    
    let namingQuizInstructions = "Naming Quiz Instructions: \nIn this quiz, an image of a person in your list will show up. You have to enter the person's name into the box to get a point."
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
