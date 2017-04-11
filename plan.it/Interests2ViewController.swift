//
//  Interests2ViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class Interests2ViewController: UIViewController {
    
    //currently says Interests
    @IBOutlet weak var titleOutlet: UILabel!
    
    @IBOutlet weak var outdoorsOutlet: UILabel!
    @IBOutlet weak var culturalOutlet: UILabel!
    @IBOutlet weak var professionalOutlet: UILabel!
    @IBOutlet weak var specialOutlet: UILabel!
    
    @IBAction func outdoorsButton(_ sender: Any) {
    }
    
    @IBAction func culturalButton(_ sender: Any) {
    }
    
    
    @IBAction func professionalButton(_ sender: Any) {
    }
    
    
    @IBAction func specialButton(_ sender: Any) {
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        
        //submit interests and segue to events tab
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
