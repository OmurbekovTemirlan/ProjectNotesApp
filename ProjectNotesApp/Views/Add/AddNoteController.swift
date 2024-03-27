//
//  AddNoteController.swift
//  ProjectNotesApp
//
//  Created by Apple on 27.3.2024.
//

import UIKit

protocol AddNoteControllerProtocol: AnyObject{
    func onAddNote(title: String, description: String)
}

class AddNoteController: AddNoteControllerProtocol {
   
    weak var view: AddNoteViewProtocol?
    var model: AddNoteModelProtocol?
    
    init(view: AddNoteViewProtocol) {
        self.view = view
        self.model = AddNoteModel(controller: self)
    }
    
    func onAddNote(title: String, description: String) {
        model?.addNote(title: title, description: description)
    }
}
