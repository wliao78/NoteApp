//
//  ViewController.swift
//  NoteApp
//
//  Created by Wei Liao on 3/1/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    var noteArray = [Note]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.note = noteArray[noteTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    //customize the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! notePrototypeCell
        cell.title.text = noteArray[indexPath.row].title
        cell.note.text = noteArray[indexPath.row].note
        cell.date.text = noteArray[indexPath.row].date
        
        //cell.textLabel?.text = noteArray[indexPath.row].title
        return cell
    }
    

    @IBOutlet weak var noteTableView: UITableView!
    
    //when screen is back to the original, the notes list will be refreshed
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }


}
// Custom Delegates

protocol DataDelegate {
    func updateArray(newArray: String)
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do{
            noteArray = try JSONDecoder().decode([Note].self, from:newArray.data(using: .utf8)!)
            print(noteArray)
        }catch{
            
            print("Failed to decode")
        }
        self.noteTableView?.reloadData()
    }
}

