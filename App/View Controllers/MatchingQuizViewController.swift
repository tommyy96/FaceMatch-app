//
//  MatchingQuizViewController.swift
//  App
//
//  Created by Tommy Yang on 7/29/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift

class MatchingQuizViewController: UIViewController {
    
    @IBOutlet weak var firstNameButton: UIButton!
    @IBOutlet weak var secondNameButton: UIButton!
    @IBOutlet weak var thirdNameButton: UIButton!
    @IBOutlet weak var fourthNameButton: UIButton!
    
    @IBOutlet weak var personImage: UIImageView!
    
    var people: Results<Person>!
    var currentPerson: Person!
    var usedPeople: [Person] = []
    
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
        setUpQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        personImage.image = nil
    }
    
    func setUpQuestion() {
        var personUsed = true
        while personUsed {
            var selected: Int = Int(arc4random_uniform(UInt32(people.count)))
            currentPerson = people[selected]
            for(var i = 0; i < usedPeople.count; i++) {
                if usedPeople[i] == currentPerson {
                    break
                }
                if i == usedPeople.count - 1 {
                    personUsed = false
                }
            }
            if usedPeople.count == 0 {
                personUsed = false
            }
        }
        usedPeople.append(currentPerson)
        personImage.image = UIImage(data: currentPerson.photo!)
        
    }
    
    @IBAction func firstNameButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func secondNameButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func thirdNameButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func fourthNameButtonPressed(sender: AnyObject) {
        
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
