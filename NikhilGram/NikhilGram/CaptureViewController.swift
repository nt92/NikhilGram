//
//  CaptureViewController.swift
//  NikhilGram
//
//  Created by Nikhil Thota on 2/23/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captureImage: UIImageView!
    @IBOutlet weak var captureDescription: UITextField!
    
    var previewImage: UIImage!
    
    @IBAction func onSubmit(sender: AnyObject) {
        let scaledImage = self.resize(self.previewImage, newSize: CGSizeMake(750, 750))
        let imageData = UIImageJPEGRepresentation(scaledImage, 0)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        
        let photo = PFObject(className: "Photo")
        photo["image"] = imageFile
        
        let post = PFObject(className: "Post")
        post["photo"] = photo
        post["caption"] = self.captureDescription.text
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print("Error saving post: \(error.description)")
            } else {
                print("Post saved successfully")
                self.captureImage.image = nil
                self.captureDescription.text = ""
                self.captureImage.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
                self.tabBarController!.selectedIndex = 0;
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            self.previewImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // Update UI to reflect selected image
            self.captureImage.image = self.previewImage
            self.captureImage.alpha = 1
            self.captureImage.backgroundColor = UIColor.whiteColor()
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func takeImageTapped(sender: AnyObject) {
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // Limit to PhotoLibrary if no camera available
        let sourceType = isCameraAvailable ? UIImagePickerControllerSourceType.Camera : UIImagePickerControllerSourceType.PhotoLibrary
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = sourceType
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.captureImage.image = nil
        self.captureDescription.text = ""
        self.captureImage.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
