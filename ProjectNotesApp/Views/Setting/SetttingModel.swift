//
//  models.swift
//  ProjectNotesApp
//
//  Created by Apple on 14.3.2024.
//

import UIKit

protocol SettingModelProtocol: AnyObject{
   
    func deleteNotes()
    
}

class SettingModel: SettingModelProtocol {
   
   weak var controller: SettingControllerProtocol?
   
    private let coreDataService = CoreDataService.shared
    
    init(controller: SettingControllerProtocol) {
        self.controller = controller
    }
    
    func deleteNotes() {
        coreDataService.deleteNotes()
    }
    
    
    
}
