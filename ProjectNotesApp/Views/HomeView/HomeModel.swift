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
    
    var notes: [String] = ["School Notes", "Funny Jokes", "Read Books", "Buy Products", "My Plans", "Information" ]

    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    
    func getNotes(){
        controller?.onSuccsesNotes(notes: notes)
    }
}

