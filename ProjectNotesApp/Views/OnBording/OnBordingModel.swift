//
//  FirstViewModel.swift
//  ProjectNotesApp
//
//  Created by Apple on 18.3.2024.
//

import UIKit

protocol FirstViewModelProtocol: AnyObject{
   
}

class FirstViewModel: FirstViewModelProtocol{
   
    weak var controller: FirstViewControllerProtocol?
    
    
    init(controller: FirstViewControllerProtocol) {
        self.controller = controller
    }
    
   
 
}
