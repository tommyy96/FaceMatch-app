//
//  MatchingQuizViewController.swift
//  App
//
//  Created by Tommy Yang on 7/29/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class MatchingQuizViewController: UIViewController {
    
    @IBOutlet weak var firstNameButton: UIButton!
    @IBOutlet weak var secondNameButton: UIButton!
    @IBOutlet weak var thirdNameButton: UIButton!
    @IBOutlet weak var fourthNameButton: UIButton!
    
    @IBOutlet weak var personImage: UIImageView!
    
    var people: Results<Person>!
    var allPeopleList: [Person] = []
    var usablePersonList: [Person] = []
    var currentPerson: Person!
    var buttonPressed: Int!
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let realm = Realm()
        people = realm.objects(Person)
        if(people.count >= 3) {
            thirdNameButton.hidden = false
        }
        if(people.count >= 4) {
            fourthNameButton.hidden = false
        }
        for i in 0..<people.count {
            allPeopleList.append(people[i])
            println(people[i].usedInQuiz)
            if !people[i].usedInQuiz {
                usablePersonList.append(people[i])
            }
        }
        println()
        setUpQuestion()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if usablePersonList.count == 0 {
            performSegueWithIdentifier("matchingToFinish", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        personImage.image = nil
    }
    
    func setUpQuestion() {
        let realm = Realm()
        allPeopleList.shuffled()
        usablePersonList.shuffled()
        currentPerson = usablePersonList[0]
        personImage.image = UIImage(data: currentPerson.photo)
        var names: ArraySlice<Person>!
        if allPeopleList.count >= 4 {
            names = allPeopleList[0...3]
            if !contains(names, currentPerson) {
                var pos: Int = Int(arc4random_uniform(UInt32(4)))
                names.removeLast()
                names.insert(currentPerson, atIndex: pos)
            }
            firstNameButton.enabled = false
            firstNameButton.setTitle(names[0].name, forState: .Normal)
            firstNameButton.enabled = true
            println(names[0].name)
            secondNameButton.enabled = false
            secondNameButton.setTitle(names[1].name, forState: .Normal)
            secondNameButton.enabled = true
            println(names[1].name)
            thirdNameButton.enabled = false
            thirdNameButton.setTitle(names[2].name, forState: .Normal)
            thirdNameButton.enabled = true
            println(names[2].name)
            fourthNameButton.enabled = false
            fourthNameButton.setTitle(names[3].name, forState: .Normal)
            fourthNameButton.enabled = true
            println(names[3].name)
        }
        else if allPeopleList.count == 3 {
            names = allPeopleList[0...2]
            firstNameButton.titleLabel!.text = names[0].name
            secondNameButton.titleLabel!.text = names[1].name
            thirdNameButton.titleLabel!.text = names[2].name
            firstNameButton.enabled = false
            firstNameButton.setTitle(names[0].name, forState: .Normal)
            firstNameButton.enabled = true
            println(names[0].name)
            secondNameButton.enabled = false
            secondNameButton.setTitle(names[1].name, forState: .Normal)
            secondNameButton.enabled = true
            println(names[1].name)
            thirdNameButton.enabled = false
            thirdNameButton.setTitle(names[2].name, forState: .Normal)
            thirdNameButton.enabled = true
            println(names[2].name)
        }
        else if allPeopleList.count == 2 {
            names = allPeopleList[0...1]
            firstNameButton.titleLabel!.text = names[0].name
            secondNameButton.titleLabel!.text = names[1].name
            firstNameButton.enabled = false
            firstNameButton.setTitle(names[0].name, forState: .Normal)
            firstNameButton.enabled = true
            println(names[0].name)
            secondNameButton.enabled = false
            secondNameButton.setTitle(names[1].name, forState: .Normal)
            secondNameButton.enabled = true
            println(names[1].name)

        }
        else {
            names = allPeopleList[0...0]
        }
        
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
    
    @IBAction func firstNameButtonPressed(sender: AnyObject) {
        buttonPressed = 1
        performSegueWithIdentifier("matchingToAfterQuestion", sender: self)
    }
    
    @IBAction func secondNameButtonPressed(sender: AnyObject) {
        buttonPressed = 2
        performSegueWithIdentifier("matchingToAfterQuestion", sender: self)
    }
    
    @IBAction func thirdNameButtonPressed(sender: AnyObject) {
        buttonPressed = 3
        performSegueWithIdentifier("matchingToAfterQuestion", sender: self)
    }
    
    @IBAction func fourthNameButtonPressed(sender: AnyObject) {
        buttonPressed = 4
        performSegueWithIdentifier("matchingToAfterQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        personImage.image = nil
        if segue.identifier == "matchingToAfterQuestion" {
            let afterQuestionViewController = segue.destinationViewController as! AfterQuestionViewController
            afterQuestionViewController.quizType = "matching"
            if usablePersonList.count == 1 {
                afterQuestionViewController.lastQuestion = true
            }
            if buttonPressed == 1 {
                if firstNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                    score = score + 1
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            else if buttonPressed == 2 {
                if secondNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                    score = score + 1
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            else if buttonPressed == 3 {
                if thirdNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                    score = score + 1
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            else if buttonPressed == 4 {
                if fourthNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                    score = score + 1
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            afterQuestionViewController.score = self.score
        }
        if segue.identifier == "matchingToFinish" {
            let finishedQuizViewContoller = segue.destinationViewController as! FinishedQuizViewController
            finishedQuizViewContoller.score = self.score
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

extension Int {
    func random() -> Int {
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
    func indexRandom() -> [Int] {
        var newIndex = 0
        var shuffledIndex:[Int] = []
        while shuffledIndex.count < self {
            newIndex = Int(arc4random_uniform(UInt32(self)))
            if !(find(shuffledIndex,newIndex) > -1 ) {
                shuffledIndex.append(newIndex)
            }
        }
        return  shuffledIndex
    }
}
extension Array {
    func shuffle() -> [T] {
        var shuffledContent:[T] = []
        let shuffledIndex:[Int] = self.count.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        return shuffledContent
    }
    mutating func shuffled() {
        var shuffledContent:[T] = []
        let shuffledIndex:[Int] = self.count.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        self = shuffledContent
    }
    func chooseOne() -> T {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
    func choose(x:Int) -> [T] {
        var shuffledContent:[T] = []
        let shuffledIndex:[Int] = x.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        return shuffledContent }
}
