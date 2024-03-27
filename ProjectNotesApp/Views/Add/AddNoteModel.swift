//
//  AddNoteModel.swift
//  ProjectNotesApp
//
//  Created by Apple on 27.3.2024.
//

import UIKit

protocol AddNoteModelProtocol: AnyObject{
    func addNote(title: String, description: String)
}

class AddNoteModel: AddNoteModelProtocol {
   
    weak var controller: AddNoteControllerProtocol?
    
    private let coreDataService = CoreDataService.shared

    init(controller: AddNoteControllerProtocol) {
        self.controller = controller
        
    }
    func addNote(title: String, description: String) {
        let id = UUID().uuidString
        let date = Date()
        coreDataService.addNote(id: id,
                                title: title,
                                description: description ,
                                date: date)    }
}
