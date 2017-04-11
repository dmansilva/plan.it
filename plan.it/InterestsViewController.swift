//
//  InterestsViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {
    
    //currently says interests
    @IBOutlet weak var titleOutlet: UILabel!
    
    
    @IBOutlet weak var musicOutlet: UILabel!
    @IBOutlet weak var socialOutlet: UILabel!
    @IBOutlet weak var sportsOutlet: UILabel!
    @IBOutlet weak var artsOutlet: UILabel!
    
    @IBAction func musicButton(_ sender: Any) {
    }
    
    @IBAction func socialButton(_ sender: Any) {
    }
   
    @IBAction func sportsButton(_ sender: Any) {
    }
    
    @IBAction func artsButton(_ sender: Any) {
    
    }
    

    override func viewDidLoad() {

        // Do any additional setup after loading the view.
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
