//
//  NewPersonViewController.swift
//  App
//
//  Created by Tommy Yang on 7/17/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import RealmSwift

class EditPersonViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var doneEditingButton: UIBarButtonItem!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var personImage: UIImageView!
    
    var person: Person? {
        didSet {
            displayPerson(person)
        }
    }
    
    var imagePicker: UIImagePickerController!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayPerson(self.person)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPerson(person: Person?) {
        if let person = person, nameTextField = nameTextField, infoTextView = infoTextView {
            nameTextField.text = person.name
            infoTextView.text = person.info
        }
        else {
            self.person = Person()
        }
    }
    
    @IBAction func doneEditingButtonPressed(sender: AnyObject) {
        let realm = Realm()
        if nameTextField.text != "" || infoTextView.text != "" {
            person!.name = nameTextField.text
            person!.info = infoTextView.text
            /*if let image = personImage.image {
                person!.photo = personImage.image
            }*/
            realm.write() {
                realm.add(self.person!)
            }
        }
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        personImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
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
