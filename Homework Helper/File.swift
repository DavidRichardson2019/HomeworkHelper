//
//  File.swift
//  Homework Helper
//
//  Created by David Richardson on 8/15/16.
//  Copyright © 2016 David Richardson. All rights reserved.
//

import Foundation
import UIKit
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
    @IBAction func AddHomework(sender: UIButton) {
        let HomeworkName = HomeworkNameTxt.text
        let DueDate = DueDateTxt.text
        let DueTime = DueTimeTxt.text
        
        
        homeworkTableView().AddObject([DueDate!, DueTime!], HomeworkName: HomeworkName!)
        
        
    }
    func hideKeyboardWhenTappedAround() {5
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}