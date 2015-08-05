//
//  FlashcardQuizViewController.swift
//  App
//
//  Created by Tommy Yang on 7/29/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class NamingQuizViewController: UIViewController {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var people: Results<Person>!
    var usablePersonList: [Person] = []
    var currentPerson: Person!
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = Realm()
        people = realm.objects(Person)
        let numPeople = people.count
        for var i = 0; i < numPeople; i++ {
            var person = people[i]
            println(person.usedInQuiz)
            if !person.usedInQuiz {
                usablePersonList.append(people[i])
            }
        }
        println()
        if usablePersonList.count == 0 {
            for var i = 0; i < people.count; i++ {
                realm.write {
                    self.people[i].usedInQuiz = false
                }
            }
        }
        else {
            setUpQuestion()
        }
    }

    override func viewDidAppear(animated: Bool) {
        if usablePersonList.count == 0 {
            performSegueWithIdentifier("namingToFinish", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpQuestion(){
        let realm = Realm()
        usablePersonList.shuffled()
        currentPerson = usablePersonList[0]
        personImage.image = UIImage(data: currentPerson.photo!)
        realm.write {
            self.currentPerson.usedInQuiz = true
        }
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("namingToAfterQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "namingToAfterQuestion" {
            let afterQuestionViewController = segue.destinationViewController as! AfterQuestionViewController
            afterQuestionViewController.quizType = "naming"
            if personNameTextField.text == currentPerson.name {
                afterQuestionViewController.rightWrong = "Right"
            }
            else {
                afterQuestionViewController.rightWrong = "Wrong"
            }
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