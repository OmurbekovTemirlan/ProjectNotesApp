//
//  HomeModel.swift
//  ProjectNotesApp
//
//  Created by Apple on 16.3.2024.
//

import UIKit

protocol HomeModelProtocol{
   
    func getNotes()
    func SearchNotes(text: String)
    
}

class HomeModel: HomeModelProtocol {
   
    var controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
   private var notes: [Note] = []
    
    private var filteredNotes: [Note] = []

    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    
    func getNotes(){
        notes = coreDataService.fetchNotes()
        filteredNotes = notes
        controller?.onSuccsesNotes(notes: filteredNotes)
    }
    func SearchNotes(text: String) {
        filteredNotes = []
        
        if text.isEmpty{
            filteredNotes = notes
            controller?.onSuccsesNotes(notes: filteredNotes)
        }else{
            filteredNotes = notes.filter({note in note.title?.uppercased().contains(text.uppercased()) == true })
            controller?.onSuccsesNotes(notes: filteredNotes)
        }
    }
    
    
}

