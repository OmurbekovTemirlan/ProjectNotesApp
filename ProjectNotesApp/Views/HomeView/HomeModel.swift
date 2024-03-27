//
//  HomeModel.swift
//  ProjectNotesApp
//
//  Created by Apple on 16.3.2024.
//

import UIKit

protocol HomeModelProtocol{
   
    func getNotes()
    
}

class HomeModel: HomeModelProtocol {
    
    var controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    var notes: [Note] = []

    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    
    func getNotes(){
        notes = coreDataService.fetchNotes()
        controller?.onSuccsesNotes(notes: notes)
    }
}

