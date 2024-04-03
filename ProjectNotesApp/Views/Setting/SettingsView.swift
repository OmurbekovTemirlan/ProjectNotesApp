//
//  SettingsView.swift
//  ProjectNotesApp
//
//  Created by Apple on 14.3.2024.
//

import UIKit

protocol SettingViewProtocol: AnyObject{
    
}



class SettingsView: UIViewController, SettingViewProtocol {
    
    var controller: SettingControllerProtocol?
    
    
    private lazy var dates: [Settings] = [Settings(nameLabel: "Language".localized(), imageName: "globe", discription: "Русский", type: .withRightBtn),
                                          Settings(nameLabel: "Dark theme".localized(), imageName: "moon", discription: "", type: .withSwitch),
                                          Settings(nameLabel: "Clear dates".localized(), imageName: "trash", discription: "", type: .usaul)]
    
    let cellId = "SettingCell"
    
    private lazy var settingsTableView = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        controller = SettingController(settingView: self)
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarEdits()
    }
    
    
    private func navBarEdits() {
        
        navigationItem.title = "Settings".localized()
        navigationItem.titleView?.tintColor = UIColor(named: "OtherColor")
        
    }
    
    private func locallizeWords(){
        navBarEdits()
        dates = [Settings(nameLabel: "Language".localized(), imageName: "globe", discription: "Русский", type: .withRightBtn),
                 Settings(nameLabel: "Dark theme".localized(), imageName: "moon", discription: "", type: .withSwitch),
                 Settings(nameLabel: "Clear dates".localized(), imageName: "trash", discription: "", type: .usaul)]
        settingsTableView.reloadData()
    }
    
    private func setupTableView(){
        view.addSubview(settingsTableView)
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            
        ])
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: cellId)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    @objc private func settingBtnTapped(){
        
    }
    @objc private func BackBtnTapped(){
        
    }
    
    
}
extension SettingsView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingTableViewCell
        cell.setup(settings: dates[indexPath.row])
        cell.delegate = self
        return cell
    }
}
extension SettingsView: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        51
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = LanguageView()
            vc.delegate = self
            let mult = 0.33
            let customDetend = UISheetPresentationController.Detent.custom {context in vc.view.frame.height * mult}
            if let sheet = vc.sheetPresentationController{
                sheet.detents = [customDetend]
                sheet.prefersGrabberVisible = true
            }
            present(vc, animated: true)
        }
        
        if indexPath.row == 2 {
            
            let alert = UIAlertController(title: "Delete".localized(), message: "You sure you want to delete all notes?".localized(), preferredStyle: .alert)
            
            let acceptAction = UIAlertAction(title: "Yes".localized(), style: .destructive)
            { action in self.controller?.onDeleteNotes() }
            
            let declineAction = UIAlertAction(title: "No".localized(), style: .cancel)
            
            alert.addAction(acceptAction)
            alert.addAction(declineAction)
            
            present(alert, animated: true)
        }
    }
}

extension SettingsView: SettingsCellDelegate{
    func didSwitchOn(isOn: Bool) {
        
        UserDefaults.standard.setValue(isOn, forKey: "isDarkTheme")
        
        if isOn == true {
            view.overrideUserInterfaceStyle = .dark
        }else{
            view.overrideUserInterfaceStyle = .light
        }
    }
}

extension SettingsView: LanguageViewDelegate{
    
    func didLanguageChoose() {
        
        locallizeWords()
        
    }
    
}
