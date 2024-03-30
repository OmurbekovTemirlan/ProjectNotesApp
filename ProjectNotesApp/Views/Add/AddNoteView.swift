//
//  AddNoteView.swift
//  ProjectNotesApp
//
//  Created by Apple on 26.3.2024.
//

import UIKit

protocol AddNoteViewProtocol: AnyObject {
    func succsesAddNote()
    func successUpdateNote()
    func succsesDelete()
    func failureDelete()
    
}

class AddNoteView: UIViewController {
    
    
    private var controller: AddNoteControllerProtocol?
    
    private var notes: Note?
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Название"
        view.backgroundImage = UIImage()
        if let note = notes{
            view.text = note.title
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.backgroundColor = .systemGray6
        if let note = notes{
            view.text = note.desc
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Сохранит", for: .normal)
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 12
        view.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        view.isEnabled = true
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
        
        
        let rightBtnItm = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteBtnTapped))
        if notes != nil{
            navigationItem.rightBarButtonItem = rightBtnItm
        }
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
        saveBtn.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        noteSearchBar.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    func setNote(note: Note){
        self.notes = note
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let isNotEmpty = !(noteSearchBar.searchTextField.text?.isEmpty ?? true) || !(noteTextView.text.isEmpty)
        saveBtn.isEnabled = isNotEmpty
        saveBtn.backgroundColor = isNotEmpty ? .systemRed : .systemGray
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    @objc  func saveButtonPressed() {
        if !(noteSearchBar.searchTextField.text?.isEmpty ?? true) || !(noteTextView.text.isEmpty) {
            
            if let note = notes {
                
                controller?.onUpdate(id: note.id ?? "", title: noteSearchBar.text ?? "", description: noteTextView.text ?? "tima")
                successUpdateNote()
            }else{
                controller?.onAddNote(title: noteSearchBar.text ?? "", description: noteTextView.text ?? "tima")
                succsesAddNote()
            }
        }
    }
    
    @objc private func deleteBtnTapped(){
        deleteFunc()
    }
    
    private func deleteFunc(){
        guard let note = notes else {return}
        let alert = UIAlertController(title: "Удаление", message: "Вы уверены, что хотите удалить заметки?", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Да", style: .destructive)
        { action in self.controller?.onDelete(id: note.id ?? "") }
        
        let declineAction = UIAlertAction(title: "Нет", style: .cancel)
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        present(alert, animated: true)
    }
    
}

extension AddNoteView: AddNoteViewProtocol{
    func succsesAddNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func successUpdateNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func succsesDelete() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDelete() {
        ()
    }
}
