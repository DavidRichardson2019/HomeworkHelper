//
//  HomeworkTableView.swift
//  Homework Helper
//
//  Created by David Richardson on 8/14/16.
//  Copyright © 2016 David Richardson. All rights reserved.
//

import Foundation
import UIKit
class homeworkTableView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    var homework : [String: [String]] = [
        "Spanish Test": ["Aug 12", "12:00 AM", "Spanish"],
        "Math Sheet": ["Aug 13", "10:30 PM","Math"],
        "Code Thing": ["Aug 11","12:00 AM","Coding"]
       
    ]
    
    
    var titles = [
        "Spanish Test", "Math Sheet", "Code Thing"
    ]
    
    func AddObject(newArray: [String], HomeworkName: String){
        titles.append(HomeworkName)
        homework.updateValue(newArray, forKey: HomeworkName)
        
        print(homework)
        print(titles)
        
        self.tableView.reloadData()
    }
    

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        Cell.Title.text = titles[indexPath.row]
        let currentTitle = titles[indexPath.row]
        let current = homework[currentTitle]!
        Cell.DueDate.text = "Due Date: \(current[0])"
        Cell.Class.text = "Due Time: \(current[1])"
        
        self.tableView.rowHeight = 100.00
        
        return Cell
    }

}