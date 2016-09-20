//
//  File.swift
//  Homework Helper
//
//  Created by David Richardson on 8/15/16.
//  Copyright © 2016 David Richardson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
class AddHomework : UIViewController {
    @IBOutlet weak var HomeworkNameLbl: UILabel!
    @IBOutlet weak var HomeworkNameTxt: UITextField!
    @IBOutlet weak var DueDateLbl: UILabel!
    @IBOutlet weak var DueDateTxt: UITextField!
    @IBOutlet weak var DueTimeLbl: UILabel!
    @IBOutlet weak var DueTimeTxt: UITextField!
    @IBOutlet weak var AddHomeworkBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func AddHomework(_ sender: UIButton) {
        if HomeworkNameTxt.text == "" {
            let alertController = UIAlertController(title: "Name Field Is Blank", message:
                "You cannot leave the Name field blank.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else {
            let HomeworkName = HomeworkNameTxt.text
            var DueDate = DueDateTxt.text
            var DueTime = DueTimeTxt.text
            if DueDateTxt.text == "" {
                DueDate = "No Due Date Specified"
            }
            if DueTimeTxt.text == "" {
                DueTime = "No Due Time Specified"
            }
            let randomNumber = arc4random_uniform(300000)
            let itemTag = "item\(randomNumber)"
            let item : [String : String] = ["HomeworkName" : HomeworkName!,
                                            "DueDate" : DueDate!,
                                            "DueTime" : DueTime!,
                                            "itemTag" : itemTag]
            let databaseRef = FIRDatabase.database().reference()
            databaseRef.child("Items").child(itemTag).setValue(item)
            //homeworkTableView().AddObject([DueDate!, DueTime!], HomeworkName: HomeworkName!)
        
        }
    }
    func hideKeyboardWhenTappedAround() {5
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
