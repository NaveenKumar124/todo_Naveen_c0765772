//
//  TaskVC.swift
//  todo_Naveen_c0765772
//
//  Created by Navi Malhotra on 2020-06-27.
//  Copyright © 2020 Naveen Kumar. All rights reserved.
//

import UIKit
import CoreData

class TaskVC: UIViewController , UITextViewDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var taskTextView: UITextView!
    
    @IBOutlet weak var TaskButton: UIButton!
    @IBOutlet weak var taskProgressField: UITextField!
    
    var editTask = ""
    var editProgress:Int16 = 0
    
    var date: String = ""
    var taskDescription:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       super.viewDidLoad()
            taskTextView.delegate = self
            taskProgressField.delegate = self
            taskTextView.text = editTask
            if taskTextView.text != "" {
                
                TaskButton.setTitle("Edit Data", for: .normal)
                
                taskTextView.becomeFirstResponder()
                self.navigationItem.setHidesBackButton(true, animated: true);
            }
           
            else {
                TaskButton.setTitle("Add Data", for: .normal)
            }
            
            taskProgressField.text = ""
            taskProgressField.text = String(editProgress)
            taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func addTaskPressed(_ sender: UIButton) {
        
        if TaskButton.titleLabel!.text == "Edit Data" {
                   
                   let newText = taskTextView.text!
                   let newProgress = Int16(taskProgressField.text!)!
                   
                editData(description: newText, progress: newProgress)
                   
                 
                   navigationController?.popToRootViewController(animated: true)
                  
               }
        else{
            if taskProgressField.text != "" && taskTextView.text != "" && taskProgressField.text != "0"{
                       
                         taskDescription = taskTextView.text!
                       saveData()
                        navigationController?.popToRootViewController(animated: true)
                   }
                   else{
                      
                       let alert = UIAlertController(title: "Empty Fields", message: "Please fill all the fields", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                       
                   }
            
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
       // taskTextView.text = ""
        taskTextView.becomeFirstResponder()
        taskTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        taskProgressField.text = ""
        taskProgressField.becomeFirstResponder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func currentDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        
        let currentDate = Date()
        let dateString = formatter.string(from: currentDate)
        NSLog("%@", dateString)
        return dateString
    }
    
    func saveData(){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
         let data = Task(context: managedContext)
               data.taskDescription = taskDescription
               data.taskDate = currentDate()
               data.progress = Int16(taskProgressField.text!)!
               data.taskCompletionValue = Int16(0)
        
        do {
            try managedContext.save()
            print("saved Successfully")
        } catch  {
            print(error)
        }
        
    }
    
    func editData(description: String , progress: Int16){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        
        let data = Task(context: managedContext)
        
        data.setValue(description, forKey: "taskDescription")
        data.setValue(progress, forKey: "progress")
        data.setValue(currentDate(), forKey: "taskDate")
        data.taskCompletionValue = Int16(0)
        
        do {
            try managedContext.save()
        } catch  {
            print(error)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
