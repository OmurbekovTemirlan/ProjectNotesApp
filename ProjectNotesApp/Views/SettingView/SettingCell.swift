//
//  TableViewCell.swift
//  ProjectNotesApp
//
//  Created by Apple on 14.3.2024.
//

import UIKit

enum SettingType{
    case withRightBtn
    case withSwitch
    case usaul
}

struct Settings  {
    var nameLabel: String
    var imageName: String
    var discription: String
    var type: SettingType
}
enum Theme: Int{
    case device
    case dark
    case light
    
    func getUSerInterfaceStyle() -> UIUserInterfaceStyle {
        switch self{
            
        case .device:
            return .unspecified
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
}

protocol SettingsCellDelegate: AnyObject{
    func didSwitchOn(isOn: Bool)
}

class SettingTableViewCell: UITableViewCell {
    
    weak var delegate: SettingsCellDelegate?
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.tintColor = UIColor(named: "OtherColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
     lazy var russianBtn: UIButton = {
        let view = UIButton(type: .system)
         view.addTarget(self, action: #selector(russiuanBtnTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()
    
    lazy var switchControl: UISwitch = {
        let view = UISwitch()
        let isOn = UserDefaults.standard.bool(forKey: "isDarkTheme")
        view.isOn = (MTUserDefaults.shared.theme.rawValue != 0)
        view.addTarget(self, action: #selector(changeBackraundSWitch), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    private func setupUI(){
        addSubview(label)
        addSubview(image)
        contentView.addSubview(russianBtn)
        contentView.addSubview(switchControl)
        
        NSLayoutConstraint.activate([
            
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            
            russianBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            russianBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            russianBtn.heightAnchor.constraint(equalToConstant: 40),
            russianBtn.widthAnchor.constraint(equalToConstant: 100),
            
            switchControl.centerYAnchor.constraint(equalTo:centerYAnchor),
            switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
        ])
    }
    
    @objc private func changeBackraundSWitch(_ sender: UISwitch) {
        delegate?.didSwitchOn(isOn: switchControl.isOn)
        
        MTUserDefaults.shared.theme = switchControl.isOn ? .dark : .device
        window?.overrideUserInterfaceStyle = MTUserDefaults.shared.theme.getUSerInterfaceStyle()
    }
    @objc private func russiuanBtnTapped(_ sender: UISwitch) {

    }

    func setup(settings: Settings){
       
        image.image = UIImage(systemName: settings.imageName)
        label.text = settings.nameLabel
        
        if settings.type == .withRightBtn {
            russianBtn.setTitle(settings.discription, for: .normal)
            russianBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            russianBtn.semanticContentAttribute = .forceRightToLeft
            switchControl.isHidden = true
        }else if settings.type == .withSwitch{
            russianBtn.isHidden = true
            
        }else if settings.type == .usaul {
            switchControl.isHidden = true
            russianBtn.isHidden = true

        }
    }
    


required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
}
