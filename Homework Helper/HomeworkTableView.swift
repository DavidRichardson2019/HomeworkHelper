//
//  HomeworkTableView.swift
//  Homework Helper
//
//  Created by David Richardson on 8/14/16.
//  Copyright © 2016 David Richardson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
var homework : [String: [String]] = [
    "Spanish Test": ["Aug 12", "12:00 AM", "Spanish"],
    "Math Sheet": ["Aug 13", "10:30 PM","Math"],
    "Code Thing": ["Aug 11","12:00 AM","Coding"]
    
]


var titles = [
    "Spanish Test", "Math Sheet", "Code Thing"
]
struct items {
    let HomeworkName : String!
    let DueDate : String!
    let DueTime : String!
    let itemTag : String!
}
class homeworkTableView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var itemArray = [items]()
    let databaseRef = FIRDatabase.database().reference()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FILTER>")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("FILTER>")
        self.tableView.reloadData()
        let ref = FIRDatabase.database().reference(fromURL: "https://homeworkhelper-75bf8.firebaseio.com/Items/Post/1")
        databaseRef.child("Items").observe(.childAdded, with: {
            
           (snapshot: FIRDataSnapshot!) in
            print(snapshot.childSnapshot(forPath: "HomeworkName").value!)
            print(snapshot.childSnapshot(forPath: "DueDate").value!)
            print(snapshot.childSnapshot(forPath: "DueTime").value!)
            let newHomeworkName = snapshot.childSnapshot(forPath: "HomeworkName").value as! String
            let newDueDate = snapshot.childSnapshot(forPath: "DueDate").value as! String
            let newDueTime = snapshot.childSnapshot(forPath: "DueTime").value as! String
            let newItemTag = snapshot.childSnapshot(forPath: "itemTag").value as! String
            print("FILTER> \(newHomeworkName), \(newDueDate), \(newDueTime) ")
            print(newHomeworkName)
            self.itemArray.insert(items(HomeworkName: "\(newHomeworkName)", DueDate: "\(newDueDate)", DueTime: "\(newDueTime)", itemTag: newItemTag), at: 0)
            self.tableView.reloadData()
        })
        print(itemArray)
    }
    

    
    func AddObject(_ newArray: [String], HomeworkName: String){
        titles.append(HomeworkName)
        homework.updateValue(newArray, forKey: HomeworkName)
        
        print(homework)
        print(titles)
        
    }
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        Cell.Title.text = itemArray[(indexPath as NSIndexPath).row].HomeworkName
        Cell.DueDate.text = "Due Date: \(itemArray[(indexPath as NSIndexPath).row].DueDate!)"
        Cell.Class.text = "Due Time: \(itemArray[(indexPath as NSIndexPath).row].DueTime!)"
        
        self.tableView.rowHeight = 100.00
        
        return Cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(itemArray)
            let itemTag = itemArray[indexPath.row].itemTag
            databaseRef.child("Items").child(itemTag!).removeValue()
            itemArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}
