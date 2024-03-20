//
//  customNavBar.swift
//  ProjectNotesApp
//
//  Created by Apple on 17.3.2024.
//


import UIKit

class CustomNavBar: UIView {
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints(){
//        addSubview(backBtn)
        addSubview(settingsLabel)
        addSubview(settingImage)
        
        NSLayoutConstraint.activate([
//            backBtn.topAnchor.constraint(equalTo: topAnchor),
//            backBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            backBtn.widthAnchor.constraint(equalToConstant: 60),
//            backBtn.heightAnchor.constraint(equalToConstant: 40),
            
            settingsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            settingImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            settingImage.heightAnchor.constraint(equalToConstant: 25),
            settingImage.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
}
