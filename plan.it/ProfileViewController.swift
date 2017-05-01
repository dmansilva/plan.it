//
//  ProfileViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/24/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase




class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var stats: UILabel!
    
    @IBOutlet weak var settings: UIBarButtonItem!
    
    // reference to the Firebase data store
    
    var dbRef = FIRDatabase.database().reference()
    
    var storage = FIRStorage.storage()
    
    
    
    
    func getUserFullName(completion: @escaping (String) -> ()) {
        
        let uid = (FIRAuth.auth()?.currentUser?.uid)!
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
            
                let firstName = value["firstName"] as? String
                
                let lastName = value["lastName"] as? String
                    
                let fullName = firstName! + " " + lastName!
                    
                completion(fullName)
                
                
            } else {
                
                completion("")
            }
            
        })
        
        
        
    }
    
    func getBio(completion: @escaping (String) -> ()) {
        
        let uid = (FIRAuth.auth()?.currentUser?.uid)!
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
                
                let bioU = value["description"] as? String
                
                completion(bioU!)
                
                
            } else {
                
                completion("")
            }
            
        })
        
        
        
    }
    
    /*
    func getImageString(completion: @escaping (String) -> ()) {
        
        let uid = (FIRAuth.auth()?.currentUser?.uid)!
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
                
                let imageString = value["image"] as? String
                
                print(imageString!)
                
                completion(imageString!)
                
                
            } else {
                
                completion("")
            }
            
        })
    }
    */
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        // makes the profile image round
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true
        
        //let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.organize, target: self, action: "buttonTouched")
        //navigationItem.rightBarButtonItem = button
        
        /*
         func buttonTouched(sender: UIBarButtonItem) {
         
         performSegue(withIdentifier: "settings", sender: self)
         }
         */
        
        //custom bar item for settings
        /*
         let button = UIButton.init(type: .custom)
         button.setImage(UIImage.init(named: "yourImageName.png"), for: UIControlState.normal)
         button.addTarget(self, action:#selector(ViewController.callMethod), for: UIControlEvents.touchUpInside)
         button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
         let barButton = UIBarButtonItem.init(customView: button)
         self.navigationItem.leftBarButtonItem = barButton
         
         */
        
        // check to see if we have a profile pic set already or not
        
        
        /*
        self.getImageString { (imageString) -> () in
            
            if imageString.characters.count > 0 {
                
                let photoReference = self.storage.reference(withPath: "userPhotos/\(imageString)")
                
                photoReference.data(withMaxSize: 1 * 1024 * 1024, completion: { data, error in
                    
                    if let error = error {
                        
                        print(error)
                        //shizzz
                    } else {
                        
                        self.profileImage.image = UIImage(data: data!)
                        
                    }
                    
                })
                // we have an image already set for profile pic
                // get imageURL
                // use the URL to get the photo from FIRStorage
                // display for profile pic: UIImage
                
                
            } else {
                
                // imageString is emply
                // extract defaultimage from FIRStorage
                // set profilePic == defaultImage to display as profilepic
                
                // profile Default
                let photoRef = self.storage.reference(withPath: "profileDefault.png")
                
                //use SDImage 
                
                //imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
                
                //self.profileImage.sd_setImage(with: photoRef)
                //self.profileImage
                
                photoRef.data(withMaxSize: 1 * 1024 * 1024, completion: { data, error in
                    
                    if let error = error {
                        
                        print(error)
                        //shizzz
                    } else {
                        
                        self.profileImage.image = UIImage(data: data!)
                        
                    }
                    
                })
                
                
                
                
            }
 
            
        }
        */
        
        
        self.getUserFullName{ (fullname) -> () in
            
            if fullname.characters.count > 0 {
                
                self.fullName.text = fullname
                
            } else {
                
                print("Not found")
            }
            
        }
        
        self.getBio { (userBio) -> () in
            
            if userBio.characters.count > 0 {
                
                self.bio.text = userBio
                
            } else {
                
                self.bio.text = " "
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /* how to implement photo storage and being able to represent their photo on their profile
 
     firebase database per user has a string representation of the image file
     if image string in database for that user is empty use default image as profile pic
     if they do have a image string in database, get it, then use that to get image from 
     firebase storage to display on profile page
     
     settingsViewController
     when we get image from camera roll we must
     download it to FirStorage in the userPhotos folder
     
     
 
 
 
    */

}
