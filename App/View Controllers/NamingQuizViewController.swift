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

class NamingQuizViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var people: Results<Person>!
    var usablePersonList: [Person] = []
    var currentPerson: Person!
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personNameTextField.delegate = self
        
        personNameTextField.becomeFirstResponder()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.navigationItem.hidesBackButton = true
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
        setUpQuestion()
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
        if usablePersonList.count == 1 {
            for var i = 0; i < people.count; i++ {
                realm.write {
                    self.people[i].usedInQuiz = false
                }
            }
        }
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("namingToAfterQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        personImage.image = nil
        if segue.identifier == "namingToAfterQuestion" {
            let afterQuestionViewController = segue.destinationViewController as! AfterQuestionViewController
            afterQuestionViewController.quizType = "naming"
            if usablePersonList.count == 1 {
                afterQuestionViewController.lastQuestion = true
            }
            if personNameTextField.text == currentPerson.name {
                score = score + 1
                afterQuestionViewController.rightWrong = "Right"
                afterQuestionViewController.score = score
            }
            else {
                afterQuestionViewController.rightWrong = "Wrong"
                afterQuestionViewController.score = score
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
extension NamingQuizViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        personNameTextField.resignFirstResponder()
        
        return false
    }
}
