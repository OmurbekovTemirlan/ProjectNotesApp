//
//  SettingController.swift
//  ProjectNotesApp
//
//  Created by Apple on 20.3.2024.
//

import UIKit

protocol SettingControllerProtocol: AnyObject{
    
   
}

class SettingController: SettingControllerProtocol {
     
   weak var settingView: SettingViewProtocol?
    var model: SettingModelProtocol?
    init(settingView: SettingViewProtocol) {
        self.settingView = settingView
        self.model = SettingModel(controller: self)
    }
    
    
}
