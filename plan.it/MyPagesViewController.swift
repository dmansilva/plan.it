//
//  MyPagesViewController.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import UIKit

class MyPagesViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let pages = ["Interest1", "Interest2"]
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Interest1")
        // Has to be a single item array, unless you're doing double sided stuff I believe
        setViewControllers([vc!], direction: .forward, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index > 0 {
                    return self.storyboard?.instantiateViewController(withIdentifier: pages[index-1])
                }
            }
        }
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index < pages.count - 1 {
                    return self.storyboard?.instantiateViewController(withIdentifier: pages[index+1])
                }
            }
        }
        return nil
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return pages.count
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        if let identifier = viewControllers?.first?.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                return index
            }
        }
        return 0
        
    }
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds // Why? I don't know.
            }
            else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    */
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
