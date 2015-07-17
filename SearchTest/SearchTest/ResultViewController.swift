//
//  ResultViewController.swift
//  SearchTest
//
//  Created by Pawanpreet Singh on 17/07/15.
//  Copyright (c) 2015 Pawanpreet Singh. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var interiorPopUpView: UIVisualEffectView!
    @IBOutlet weak var popUpView: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var keywordsLabel: UILabel!
    
    var searchArray = [""]
    var someData = ["Snippet 1","Snippet 2","Snippet 3","Snippet 4","Snippet 5","Snippet 6","Snippet 7","Snippet 8","Snippet 9","Snippet 10"]
    
    override func viewDidLoad() {
        self.interiorPopUpView.alpha = 0
        super.viewDidLoad()
        keywordsLabel.text = ""
        for (var i=0; i < searchArray.count; i++){
            keywordsLabel.text = searchArray[i] + "   " + keywordsLabel.text!
        }
        popUpView.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func popUpButtonAction(sender: AnyObject) {
       popUpView.hidden = false
        //tableView.hidden = true
        
        UIView.animateWithDuration(1.0, delay: 1.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {

            self.interiorPopUpView.alpha = 1
            self.interiorPopUpView.center = CGPointMake(self.popUpView.center.x , self.popUpView.center.y  )
            
            }, completion: nil)

//        UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
//            self.interiorPopUpView.layer.transform = CATransform3DMakeScale(0.5,0.5,0)
//            self.interiorPopUpView.layer.transform = CATransform3DMakeScale(1,1,1)
//            
//
//        }, completion: nil)
//        
            }

    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return someData.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = someData[indexPath.row]
        
        return cell
    }

    @IBAction func interiorDoneButton(sender: AnyObject) {
       // popUpView.hidden = true
       // tableView.hidden = false
        
        UIView.animateWithDuration(1.0, delay: 1.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            self.interiorPopUpView.alpha = 1
            self.interiorPopUpView.center = CGPointMake(self.interiorPopUpView.center.x  + (self.popUpView.center.x * 2) , self.interiorPopUpView.center.y - (self.popUpView.center.y * 2) )
            
            }, completion: { finished in
            
                self.popUpView.hidden = true
            }
        )
        
        //popUpView.hidden = true
        
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
