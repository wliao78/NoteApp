//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by Wei Liao on 3/1/21.
//

import UIKit

class AddNoteViewController: UIViewController {

    var note: Note?
    var update = false
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func deleteClick(_ sender: Any) {
        APIFunctions.functions.deleteNote(_id: note!._id)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveClick(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        if update == true {
            APIFunctions.functions.updateNote(date: date, title: titleTextField.text!, note: bodyTextView.text, _id: note!._id)
            self.navigationController?.popViewController(animated: true) //after click save button, it will go back to original screen
        } else if titleTextField.text != "" && bodyTextView.text != ""
            {
            APIFunctions.functions.AddNote(date: date, title: titleTextField.text!, note: bodyTextView.text)
            self.navigationController?.popViewController(animated: true) //after click save button, it will go back to original screen
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if update == true {
            titleTextField.text = note!.title
            bodyTextView.text = note!.note
        }
        // Do any additional setup after loading the view.
        
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
