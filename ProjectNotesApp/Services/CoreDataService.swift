//
//  CoreDataService.swift
//  ProjectNotesApp
//
//  Created by Apple on 26.3.2024.
//

import UIKit
import CoreData

class CoreDataService: NSObject {
    
    static let shared = CoreDataService()
    
    private override init() {
        
    }
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
//    CRUD
//    CREAT READ UPDATE DELETE
    
    //creat
    func addNote(id: String, title: String, description: String, date: Date){
        guard let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            return
        }
        let note = Note(entity: noteEntity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        
        appDelegate.saveContext()
    }
    // read
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    // deleete
    
    func deleteNote(id: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: {note in id == note.id
            })else {
                return
            }
            context.delete(note)
        }catch {
            
        }
    }
}

//func deleteNotes(){
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//    do {
//        let notes = try context.fetch(fetchRequest) as! [Note]
//        notes.forEach({ note in context.delete(note)
//        })
//    }catch {
//        
//    }
//}
//func updateNote(id: String, title: String, description: String){
//   let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//    
//}
