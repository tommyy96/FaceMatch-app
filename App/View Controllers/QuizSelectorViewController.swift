//
//  QuizSelectorViewController.swift
//  App
//
//  Created by Tommy Yang on 7/27/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit

class QuizSelectorViewController: UIViewController {
    
    @IBOutlet weak var quizSelectorPickerView: UIPickerView!
    @IBOutlet weak var donePickingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func donePickingButonPressed(sender: AnyObject) {
        
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
