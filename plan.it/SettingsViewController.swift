//
//  SettingsViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/26/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit
import Firebase
import Photos

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // reference to the Firebase data store
    var dbRef: FIRDatabaseReference!
    // reference to the Firebase storage
    var storage: FIRStorageReference!
    
    var imageURL = ""
    let uid = (FIRAuth.auth()?.currentUser?.uid)!
    
   
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            
        // get the image from the user's photo library and put it in PNGrepresentation
        let imageData = UIImagePNGRepresentation(image)!
        // converts the png to string representation to store into the database
        //let stringRep = imageData.base64EncodedString(options: .lineLength64Characters)
        
        //print("string Rep is : " + stringRep)
        
        // put the stringRep into the database for that userID
            
            
            // take the image, get the fileName
            // save fileName into Database: image 
            // download image to FIRStorage
            
            ///profileImage.image = image
            
            // update image for profile in firebase database
            
        
        
        // get reference to the location where we'll store our photos
        storage = storage.child("userPhotos").child("\(self.uid).png")
        
        //let photoRef = photosRef.child("\(NSUUID().uuidString).png")
        
        
        self.storage.put(imageData, metadata: nil, completion: { (metadata: FIRStorageMetadata?, error: Error?) in
            
            
            if error != nil {
                
                print("error is: ")
                print(error!)
                
                
            } else if let storageMetadata = metadata {
                
                if let imageURL = storageMetadata.downloadURL() {
                    
                    self.setImageURL(imageURL: imageURL.absoluteString)
                }
            }
            //let text = snapshot.metadata?.downloadURL()?.absoluteString
            //print("text is : " + text!)
            // save the URL (text) to a variable so that it can be put into the database as reference
            // call a function that puts the URL to imageString in database
            //self.setImageURL(imageURL: text!)
        })
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // function to take the URL (text) and save it into database at imageString
    
    func setImageURL(imageURL: String) {
        
        
        print("imageURL is " + imageURL)
        
        self.dbRef.child("users/\(uid)/image").setValue(imageURL)
        
        
    }
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBAction func picChange(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    /*
     func getImageString(completion: @escaping (String) -> ()) {
     
        let uid = (FIRAuth.auth()?.currentUser?.uid)!
     
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
     
     
            if let value = snapshot.value as? NSDictionary {
     
                    let imageString = value["image"] as? String
     
                    print("imageString is : " + imageString!)
     
                    completion(imageString!)
     
     
            } else {
     
                completion("")
            }
     
        })
     }
    */
    
    func getImage() {
        
        
        //let photoReference = self.dbRef.child("userPhotos").child(self.uid + ".png")
        //let photoReference = self.dbRef.child("userPhotos")
        
        self.dbRef.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            
            if let firebaseValue = snapshot.value as? NSDictionary {
                
                 self.imageURL = firebaseValue["image"] as! String
                
                 print("self.imageURL :" + self.imageURL)
                
            }
            
            if self.imageURL.characters.count > 0 {
                
                //let picURL: URL = URL(string: self.imageURL)!
                /*
                self.storage.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                
                    if let dataError = error {
                        
                        print("error is :")
                        print(dataError.localizedDescription)
                    } else {
                        
                        self.profileImage.image = UIImage(data: data!)
                    }
                }
                */
                
                let picURL = self.storage.child("userPhotos/\(self.uid).png")
                
                picURL.downloadURL { url, error in
                
                    if let sessionError = error {
                        
                        print("error is :")
                        print(sessionError.localizedDescription)
                    } else {
                        
                        let data = NSData(contentsOf: url!)
                        let image = UIImage(data: data! as Data)
                        self.profileImage.image = image
                        
                    }
                }
            
        
            } else {
                
                // the user has no profile image and need to have the defaultImage put in
                
                
            }
            
            
        }
            
            
            
            
            
    }
    
    
    
    
    @IBAction func submitChanges(_ sender: Any) {
        
        
        if (self.firstName.text?.characters.count)! > 0 {
            
            // update firstName to database
            
            self.dbRef.child("users/\(uid)/firstName").setValue(self.firstName.text)
        }
        
        if (self.lastName.text?.characters.count)! > 0 {
            
            // update lastName to database
            
            self.dbRef.child("users/\(uid)/lastName").setValue(self.lastName.text)
        }
        
        if (self.bio.text?.characters.count)! > 0 {
            
            // update bio to database
            
            self.dbRef.child("users/\(uid)/description").setValue(self.bio.text)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage = FIRStorage.storage().reference()
        dbRef = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true
        
        
        self.getImage()
        
        
        // call function to get current imageURL from the database
        // if it is empty, then use defaultPhoto 
        
        // else, get URL using completion
        
        // call completion and use it to get the picture to display from FIRStorage
        
        /*
         self.getImageString { (imageString) -> () in
 
            if imageString.characters.count > 0 {
 
                //let photoReference = self.storage.reference(withPath: "userPhotos/\(imageString)")
                let photoReference = self.storage.child("userPhotos").child(self.uid + ".png")
                
                
                photoReference.data(withMaxSize: 1 * 1024 * 1024, completion: { data, error in
 
                    if let error = error {
                        
                        print("Error below:")
                        print(error)
                        //shizzz
    
                    } else {
                        
                        print("made it here, putting image to profilePic")
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
                //let photoRef = self.storage.reference(withPath: "profileDefault.png")
 
                    //use SDImage
 
                    //imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
 
                    //self.profileImage.sd_setImage(with: photoRef)
                    //self.profileImage
 
                /*
                photoRef.data(withMaxSize: 1 * 1024 * 1024, completion: { data, error in
 
                        if let error = error {
 
                            print(error)
                            //shizzz
                            
                        } else {
 
                            self.profileImage.image = UIImage(data: data!)
 
                        }
 
                })
                */
 
 
            }
            
        }
        */
 
    
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

}
