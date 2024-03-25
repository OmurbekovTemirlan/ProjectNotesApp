//
//  FirstViewController.swift
//  ProjectNotesApp
//
//  Created by Apple on 20.3.2024.
//

import UIKit

protocol FirstViewControllerProtocol: AnyObject{
   
    
}

class FirstViewController: FirstViewControllerProtocol{
   
    
   
    weak var view: OnBordingViewProtocol?
     var model: FirstViewModelProtocol?
    
    init(view: OnBordingViewProtocol) {
        self.view = view
        self.model = FirstViewModel(controller: self)
    }
    
    
   
    
}
