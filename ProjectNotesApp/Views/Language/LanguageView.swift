//
//  LanguageView.swift
//  ProjectNotesApp
//
//  Created by Apple on 29.3.2024.
//

import UIKit
protocol LanguageViewDelegate: AnyObject{
    func didLanguageChoose()
}
class LanguageView: UIViewController{
    
    weak var delegate: LanguageViewDelegate!
    
    private var cellDates: [LanguagesStruct] = [LanguagesStruct(image: "kg", label: "Кыргызча"),
                                                LanguagesStruct(image: "rus", label: "Русский"),
                                                LanguagesStruct(image: "us", label: "Англиский"),
    ]
    
    private lazy var labell: UILabel = {
        let lb = UILabel()
        lb.text = "Choose language".localized()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 17, weight: .bold)
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
        NSLayoutConstraint.activate([
                  
            labell.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            labell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            languageTableView.topAnchor.constraint(equalTo: labell.bottomAnchor, constant: 16),
            languageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            languageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            languageTableView.heightAnchor.constraint(equalToConstant: 160)
            
        ])
        
        languageTableView.dataSource = self
        languageTableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.cellID)
        languageTableView.delegate = self
        languageTableView.translatesAutoresizingMaskIntoConstraints = false
        languageTableView.backgroundColor = .systemGray5
        languageTableView.layer.cornerRadius = 14
    }
    
    private func localTextWords(){
        labell.text =  "Choose language".localized()
    }
    
    @objc private func backBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}



extension LanguageView: UITableViewDataSource{
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

extension LanguageView:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            switch indexPath.row{
            case 0:
                AppLanguageManager.shared.setApplanguage(language: .kg)
            case 1:
                AppLanguageManager.shared.setApplanguage(language: .ru)
            case 2:
                AppLanguageManager.shared.setApplanguage(language: .en)
            default:
                ()
            }
            localTextWords()
            delegate?.didLanguageChoose()
        
    }
}

