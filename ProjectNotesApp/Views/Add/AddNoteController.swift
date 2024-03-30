//
//  AddNoteController.swift
//  ProjectNotesApp
//
//  Created by Apple on 27.3.2024.
//

import Foundation



protocol AddNoteControllerProtocol: AnyObject{
    func onAddNote(title: String, description: String)
    func onDelete(id: String)
    func onUpdate(id: String, title: String, description: String)
    func onSuccsesDelete()
    func onFailureDelete()
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
    
    func onDelete(id: String) {
        model?.deleteNote(id: id)
    }
    
    func onUpdate(id: String, title: String, description: String) {
        model?.updeteNote(id: id, title: title, description: description)
    }
    
    func onSuccsesDelete() {
        view?.succsesDelete()
    }
    
    func onFailureDelete() {
        ()
    }
    
    
}
