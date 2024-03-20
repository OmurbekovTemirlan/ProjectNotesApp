//
//  SettingsView.swift
//  ProjectNotesApp
//
//  Created by Apple on 14.3.2024.
//

import UIKit

protocol SettingViewProtocol: AnyObject{
   
}

class SettingsView: UIViewController {
    
    var controller: SettingControllerProtocol?
    
    
   private lazy var dates: [Settings] = [Settings(nameLabel: "Язык", imageName: "language", discription: "Русский", type: .withRightBtn),
                             Settings(nameLabel: "Темная тема", imageName: "moon", discription: "", type: .withSwitch),
                             Settings(nameLabel: "Очистить данные", imageName: "trash", discription: "", type: .usaul)]
    
    let cellId = "SettingCell"
    
    private lazy var settingsTableView = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       NavBarEdits()
//        controller = SettingController(settingView: self)
        setupTableView()
    }
    
   
    
    private func NavBarEdits() {
        
        navigationItem.title = "Настройки"
        
        
    
        let rightBarBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingBtnTapped))
        navigationItem.rightBarButtonItem = rightBarBtn
        rightBarBtn.tintColor = .black
 
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
