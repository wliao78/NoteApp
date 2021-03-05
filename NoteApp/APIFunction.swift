//
//  APIFunction.swift
//  NoteApp
//
//  Created by Wei Liao on 3/1/21.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var title: String
    var date: String
    var _id: String
    var note: String
}

class APIFunctions {
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchNotes() {
        
        AF.request("http://192.168.86.27:8081/fetch").response { response in
            print(response.data)
            
            let data = String (data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func AddNote(date:String, title: String, note: String) {
        AF.request("http://192.168.86.27:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON {
            response in
            print(response)
        }
    }
    
    func updateNote(date:String, title: String, note: String, _id: String){
        AF.request("http://192.168.86.27:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "_id": _id]).responseJSON {
            response in
            print(response)
        }
    }
    
    func deleteNote(_id: String){
        AF.request("http://192.168.86.27:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["_id": _id]).responseJSON {
            response in
            print(response)
        }
    }
}
