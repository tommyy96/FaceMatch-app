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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = Realm()
        people = realm.objects(Person)
        if(people.count >= 3) {
            thirdNameButton.hidden = false
        }
        if(people.count >= 4) {
            fourthNameButton.hidden = false
        }
        let numPeople = people.count
        for var i = 0; i < numPeople; i++ {
            allPeopleList.append(people[i])
            if true {
                usablePersonList.append(people[i])
                realm.write {
                    self.people[i].usedInQuiz = true
                }
            }
        }
        setUpQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        personImage.image = nil
    }
    
    func setUpQuestion() {
        usablePersonList.shuffled()
        currentPerson = usablePersonList[0]
        var names: ArraySlice<Person>
        allPeopleList.shuffled()
        if people.count > 3 {
            var nameInChosen = false
            names = allPeopleList[0...3]
            for var i = 0; i < names.count; i++ {
                if currentPerson.name == names[i] {
                    nameInChosen = true
                    break
                }
            }
            if !nameInChosen {
                names = allPeopleList[0...2]
                names.append(currentPerson)
            }
            firstNameButton.titleLabel?.text = names[0].name
            secondNameButton.titleLabel?.text = names[1].name
            thirdNameButton.titleLabel?.text = names[2].name
            fourthNameButton.titleLabel?.text = names[3].name
        }
        else if people.count == 3 {
            names = allPeopleList[0...2]
            firstNameButton.titleLabel?.text = names[0].name
            secondNameButton.titleLabel?.text = names[1].name
            thirdNameButton.titleLabel?.text = names[2].name
        }
        else if people.count == 2 {
            names = allPeopleList[0...1]
            firstNameButton.titleLabel?.text = names[0].name
            secondNameButton.titleLabel?.text = names[1].name
        }
        personImage.image = UIImage(data: currentPerson.photo!)
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
        if segue.identifier == "matchingToAfterQuestion" {
            let afterQuestionViewController = segue.destinationViewController as! AfterQuestionViewController
            afterQuestionViewController.quizType = "matching"
            if buttonPressed == 1 {
                if firstNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            else if buttonPressed == 2 {
                if secondNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            else if buttonPressed == 3 {
                if thirdNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
            }
            else if buttonPressed == 4 {
                if fourthNameButton.titleLabel?.text == currentPerson.name {
                    afterQuestionViewController.rightWrong = "Right"
                }
                else {
                    afterQuestionViewController.rightWrong = "Wrong"
                }
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
