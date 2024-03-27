//
//  AddNoteView.swift
//  ProjectNotesApp
//
//  Created by Apple on 26.3.2024.
//

import UIKit

protocol AddNoteViewProtocol: AnyObject {
    
}

class AddNoteView: UIViewController {
    
    
    private var controller: AddNoteControllerProtocol?
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Название"
        view.backgroundImage = UIImage()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Сохранит", for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) /*UIColor(hex: "#FF3D3D" )*/
        view.layer.cornerRadius = 12
        view.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupContriants()
        controller = AddNoteController(view: self)
        navBarItem()
    }
    
    private func navBarItem(){
        
        navigationItem.title = "Заметки"
        
        navigationItem.titleView?.tintColor = UIColor(named: "OtherColor")
    }
    
    private func setupContriants(){
        view.addSubview(noteSearchBar)
        view.addSubview(noteTextView)
        view.addSubview(saveBtn)
        
        NSLayoutConstraint.activate([
            noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            noteSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteSearchBar.heightAnchor.constraint(equalToConstant: 50),
        
            noteTextView.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 10),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            saveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveBtn.heightAnchor.constraint(equalToConstant: 40),
            saveBtn.widthAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    
    @objc private func saveButtonTapped(){
        controller?.onAddNote(title: noteTextView.text ?? "", description: "someDescription")
    }
}
extension AddNoteView: AddNoteViewProtocol{
    
}
