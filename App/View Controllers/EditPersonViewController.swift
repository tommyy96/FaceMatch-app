
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
    
    var person: Person?
    
    var imagePicker: UIImagePickerController!
    
    var showedPicture = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        displayPerson(self.person)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        personImage.image = nil
    }
    
    func displayPerson(person: Person?) {
        if let person = person, nameTextField = nameTextField, infoTextView = infoTextView, personImage = personImage {
            nameTextField.text = person.name
            infoTextView.text = person.info
            if let image = person.photo {
                if !showedPicture {
                    personImage.image = UIImage(data: person.photo!)
                    showedPicture = true
                }
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
                    self.person!.photo = UIImagePNGRepresentation(personImage.image)//UIImagePNGRepresentation(AppHelper.scaleImage(personImage.image!, width: 320))
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
                        self.person!.photo = UIImagePNGRepresentation(self.personImage.image)
                        
                    }

                }
            }
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        let realm = Realm()
        realm.write(){
            if let name = self.nameTextField.text {
                self.person!.name = self.nameTextField.text
            }
            if let info = self.infoTextView.text {
                self.person!.info = self.infoTextView.text
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
        personImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        println(personImage.image?.imageOrientation)
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
