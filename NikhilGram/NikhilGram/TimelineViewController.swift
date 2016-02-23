//
//  TimelineViewController.swift
//  NikhilGram
//
//  Created by Nikhil Thota on 2/23/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.posts == nil{
            return 0
        }
        else{
            return self.posts.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as! TimelineCell
        cell.Post = posts[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 350
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Retrieving Instagram Posts from Parse...")
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("photo")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let results = results {
                    print("Successfully retrieved \(results.count) posts")
                    self.posts = results
                    self.tableView.reloadData()
                } else {
                    print("No results returned")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
