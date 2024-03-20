//
//  models.swift
//  ProjectNotesApp
//
//  Created by Apple on 14.3.2024.
//

import UIKit

protocol SettingModelProtocol: AnyObject{
   
    
}

class SettingModel: SettingModelProtocol {
    
   weak var controller: SettingControllerProtocol?
    
    
    
    init(controller: SettingControllerProtocol) {
        self.controller = controller
        
    }
    
}
