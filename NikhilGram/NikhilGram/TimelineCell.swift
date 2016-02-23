//
//  TimelineCell.swift
//  NikhilGram
//
//  Created by Nikhil Thota on 2/23/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TimelineCell: UITableViewCell {

    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    
    var Post: PFObject! {
        didSet {
            self.postDescription.text = Post["caption"] as? String
            let photo = Post["photo"] as! PFObject
            self.postImage.file = photo["image"] as? PFFile
            self.postImage.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
