//
//  QuizSelectorViewController.swift
//  App
//
//  Created by Tommy Yang on 7/27/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift

class QuizSelectorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var quizSelectorPickerView: UIPickerView!
    @IBOutlet weak var donePickingButton: UIButton!
    
    let pickerData = ["Matching Quiz", "Flashcard Quiz"]
    
    var chosenQuiz: String = "Matching Quiz"
    var people: Results<Person>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = Realm()
        quizSelectorPickerView.dataSource = self
        quizSelectorPickerView.delegate = self
        people = realm.objects(Person)
        if people.count <= 1 {
           performSegueWithIdentifier("noPeopleInList", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func donePickingButtonPressed(sender: AnyObject) {
        if(chosenQuiz == pickerData[0]) {
            performSegueWithIdentifier("pickerToMatchingQuiz", sender: self)
        }
        else if(chosenQuiz == pickerData[1])  {
            performSegueWithIdentifier("pickerToFlashcardQuiz", sender: self)
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         chosenQuiz = pickerData[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
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
