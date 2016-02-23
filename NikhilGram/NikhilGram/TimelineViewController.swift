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
            return  self.posts.count
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
