//
//  HomeController.swift
//  ProjectNotesApp
//
//  Created by Apple on 16.3.2024.
//

import UIKit

protocol HomeControllerProtocol{
    
    func onGetNotes()
    func onSuccsesNotes(notes: [Note])
    func onSearchNotes(text: String)
    
}

class HomeController: HomeControllerProtocol {
    
    private var model: HomeModelProtocol?
    private var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol) {
        self.model = HomeModel(controller: self)
        self.view = view
    }
    
    func onGetNotes(){
        model?.getNotes()
    }
    
    func onSuccsesNotes(notes: [Note]){
        view?.succsesNotes(notes: notes)
    }
    
    func onSearchNotes(text: String) {
        model?.SearchNotes(text: text)
    }
    
}
