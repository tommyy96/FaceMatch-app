//
//  Person.swift
//  App
//
//  Created by Tommy Yang on 7/16/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
   
    dynamic var name: String = ""
    dynamic var info: String = ""
    dynamic var photo: NSData?
    dynamic var newPerson: Bool = true
    dynamic var usedInQuiz: Bool = false
    
//  func UIImage
    
}
