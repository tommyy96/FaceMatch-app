//
//  FlashcardQuizViewController.swift
//  App
//
//  Created by Tommy Yang on 7/29/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift

class NamingQuizViewController: UIViewController {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    var people: Results<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = Realm()
        people = realm.objects(Person)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpQuestion(){
        
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
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