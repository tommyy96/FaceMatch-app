//
//  PersonViewController.swift
//  App
//
//  Created by Tommy Yang on 7/17/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift

class PersonViewController: UIViewController {
    
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personInfoTextView: UITextView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    var person: Person? {
        didSet {
            displayPerson(person)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayPerson(person)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        personImageView.image = nil
    }
    
    func displayPerson(person: Person?) {
        if let person = person , personNameLabel = personNameLabel, personInfoTextView = personInfoTextView, personImageView = personImageView {
            self.personNameLabel.text = person.name
            self.personInfoTextView.text = person.info
            self.personImageView.image = UIImage(data: person.photo)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        personImageView.image = nil
        if segue.identifier == "editPerson" {
            let editPersonViewController = segue.destinationViewController as! EditPersonViewController
            editPersonViewController.person = self.person
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
