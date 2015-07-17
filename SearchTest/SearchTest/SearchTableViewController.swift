//
//  SearchTableViewController.swift
//  SearchTest
//
//  Created by Pawanpreet Singh on 16/07/15.
//  Copyright (c) 2015 Pawanpreet Singh. All rights reserved.
//

import UIKit

extension String {
    
    var length: Int {
        get {
            return count(self)
        }
    }
    
    func indexOf(target: String) -> Int {
        var range = self.rangeOfString(target)
        if let range = range {
            return distance(self.startIndex, range.startIndex)
        } else {
            return -1
        }
    }
    
    func indexOf(target: String, startIndex: Int) -> Int {
        var startRange = advance(self.startIndex, startIndex)
        var range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        if let range = range {
            return distance(self.startIndex, range.startIndex)
        } else {
            return -1
        }
    }
    
    func lastIndexOf(target: String) -> Int {
        var index = -1
        var stepIndex = self.indexOf(target)
        while stepIndex > -1 {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    func substringWithRange(range:Range<Int>) -> String {
        let start = advance(self.startIndex, range.startIndex)
        let end = advance(self.startIndex, range.endIndex)
        return self.substringWithRange(start..<end)
    }
    
}

class SearchTableViewController: UITableViewController ,UISearchResultsUpdating{

    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var searchArray = [String]()
    
    let tableData = ["iOS","Windows","Swift","Java","JavaScript"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var count = 0
    var totalCount = 0
    
    var searchBarFinalText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.enabled = false

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = true
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return self.tableData.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // 3
        if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
           cell.textLabel?.text = tableData[indexPath.row]
            
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        var preSearchText = "\(searchController.searchBar.text)"
        
        NSLog(preSearchText)
        
         NSLog("\(count)")
        
        var searchText = preSearchText.substringWithRange(totalCount ..< preSearchText.length)
        
        NSLog(searchText)
       
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        // Unwrap that optional
        if let label = cell?.textLabel?.text {
            println("\(label)")
           count = label.length
           //totalCount =  count + 2
           totalCount = totalCount + count + 2
            searchBarFinalText = searchBarFinalText + "\(label), "
                    resultSearchController.searchBar.text = searchBarFinalText
            searchArray.append("\(label)")
        }
        doneButton.enabled = true
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
  
    @IBAction func doneAction(sender: AnyObject) {
        
        
    }
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! ResultViewController
        
        dest.searchArray = searchArray
        
        
    }
    

}
