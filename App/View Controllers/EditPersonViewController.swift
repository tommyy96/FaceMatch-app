
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
    @IBOutlet weak var addPhotoButtonOnPhoto: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var personImage: UIImageView!
    
    var person: Person?
    
    var imagePicker: UIImagePickerController!
    
    var showedPicture = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //AppHelper.runInBackgroundWithBlock { () -> Void in
        self.displayPerson(self.person)
        //}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        personImage.image = nil
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func displayPerson(person: Person?) {
        if let person = person, nameTextField = nameTextField, infoTextView = infoTextView, personImage = personImage {
            nameTextField.text = person.name
            infoTextView.text = person.info
            if !showedPicture {
                personImage.image = UIImage(data: person.photo)
                showedPicture = true
                addPhotoButtonOnPhoto.hidden = true
            }
        }
        else {
            self.person = Person()
        }
    }
    
    @IBAction func doneEditingButtonPressed(sender: AnyObject) {
        let realm = Realm()
        if nameTextField.text != "" && infoTextView.text != "" {
            if person!.newPerson {
                self.person!.name = nameTextField.text
                self.person!.info = infoTextView.text
                self.person!.newPerson = false
                if let image = personImage.image {
                    self.person!.photo = UIImageJPEGRepresentation(self.personImage.image, 1.0)//UIImagePNGRepresentation(AppHelper.scaleImage(personImage.image!, width: 320))
                }
                else {
                    self.person!.photo = UIImagePNGRepresentation(UIImage(named: "user"))
                }
                realm.write() {
                    realm.add(self.person!)
                }
            }
            else {
                realm.write(){
                    self.person!.name = self.nameTextField.text
                    self.person!.info = self.infoTextView.text
                    if let image = self.personImage.image {
                        self.person!.photo = UIImageJPEGRepresentation(self.personImage.image, 1.0)
                    }
                }
            }
            navigationController?.popToRootViewControllerAnimated(true)
        }
        else {
            let alertController = UIAlertController(title: "Not enough information", message: "Please fill out all of the empty fields", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        let realm = Realm()
        realm.write(){
            if let name = self.nameTextField.text {
                self.person!.name = name
            }
            if let info = self.infoTextView.text {
                self.person!.info = info
            }
        }
        self.imagePicker =  UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .Camera
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        displayPerson(self.person)
        personImage.image = nil
        personImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        personImage.hidden = false
        addPhotoButtonOnPhoto.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        personImage.image = nil
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
