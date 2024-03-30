//
//  LanguageView.swift
//  ProjectNotesApp
//
//  Created by Apple on 29.3.2024.
//

import UIKit
class LanguageView: UIViewController{
   
    private var cellDates: [LanguagesStruct] = [LanguagesStruct(image: "kg", label: "Кыргызстан"),
                                                LanguagesStruct(image: "rus", label: "Россия"),
                                                LanguagesStruct(image: "us", label: "США"),
    ]
    
    private lazy var labell: UILabel = {
        let lb = UILabel()
        lb.text = "Выберите язык"
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var backBtn: UIButton = {
        let lb = UIButton()
        lb.setImage(UIImage(named: "graber"), for: .normal)
        lb.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
     lazy var languageTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCon()
    }
    
    private func setupCon(){
        view.addSubview(labell)
        view.addSubview(languageTableView)
        view.addSubview(backBtn)
        NSLayoutConstraint.activate([
            
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            backBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backBtn.heightAnchor.constraint(equalToConstant: 5),
            backBtn.widthAnchor.constraint(equalToConstant: 30),
            
            labell.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 30),
            labell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            languageTableView.topAnchor.constraint(equalTo: labell.bottomAnchor, constant: 16),
            languageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            languageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            languageTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -200),
            
        ])
        
        languageTableView.dataSource = self
        languageTableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.cellID)
        languageTableView.delegate = self
        languageTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func backBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}



extension LanguageView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let language = cellDates[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.cellID, for: indexPath) as! LanguageCell
        cell.setDates(dates: language)
        return cell
    }
    
   
    
}

