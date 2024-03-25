//
//  ViewController.swift
//  ProjectNotesApp
//
//  Created by Apple on 14.3.2024.
//

import UIKit

protocol HomeViewProtocol {
    func succsesNotes(notes: [String])
}

class HomeView: UIViewController {
    
    private var notes: [String] = []
    
    private var controller: HomeControllerProtocol?
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.backgroundImage = UIImage()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var notesLabel: UILabel = {
        let view = UILabel()
        view.text = "Заметки"
        view.textColor = UIColor(named: "OtherColor")
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(HomeViewCell.self, forCellWithReuseIdentifier: HomeViewCell.cellId)
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(named: "pluus")
        view.setTitle("+", for: .normal)
        view.setTitleColor(UIColor(named: "BackraundColor"), for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        view.layer.cornerRadius = 42 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = HomeController(view: self)
        
        setupUI()
        controller?.onGetNotes()
        navBarItem()
        navigationItem.hidesBackButton = true
        
    }
    
    
    
    
    private func navBarItem(){
        
        navigationItem.title = "Главная"
        
        navigationItem.titleView?.tintColor = UIColor(named: "OtherColor")
        
        let settingRightBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingRightBarBTnTapped))
        
        navigationItem.rightBarButtonItem = settingRightBtn
        
        settingRightBtn.tintColor = UIColor(named: "OtherColor")
        
    }
    
    private func setupUI(){
        view.addSubview(noteSearchBar)
        view.addSubview(notesLabel)
        view.addSubview(notesCollectionView)
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            noteSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteSearchBar.heightAnchor.constraint(equalToConstant: 50),
            
            notesLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 22),
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            notesCollectionView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 40),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 42),
            addButton.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
    
    
    @objc private func settingRightBarBTnTapped(){
        let settingsVC =  SettingsView()
        
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
}
extension HomeView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.cellId, for: indexPath) as! HomeViewCell
        cell.setup(title: notes[indexPath.row])
        
        return cell
    }
    
    
}
extension HomeView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 60) / 2, height: 100)
    }
}

extension HomeView: HomeViewProtocol {
    func succsesNotes(notes: [String]){
        self.notes = notes
        notesCollectionView.reloadData()
    }
}
