//
//  PersonCell.swift
//  App
//
//  Created by Tommy Yang on 7/17/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit
import Foundation

class PersonCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    var person: Person? {
        didSet {
            if let person = person, nameLabel = nameLabel, personImage = personImage {
                self.nameLabel.text = person.name
                if let image = person.photo {
                    self.personImage.image = UIImage(data: person.photo!)
                }
            }
            else {
                self.nameLabel.text = "error"
            }
        }
    }

}
