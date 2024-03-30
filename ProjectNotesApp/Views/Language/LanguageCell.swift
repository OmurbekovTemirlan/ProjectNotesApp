//
//  LanguageCell.swift
//  ProjectNotesApp
//
//  Created by Apple on 29.3.2024.
//

import UIKit
    
    struct LanguagesStruct {
        var image: String
        var label: String
    }
    
    class LanguageCell: UITableViewCell {
        
        static let cellID = "cell_ID"
        
        private lazy var labell: UILabel = {
            let lb = UILabel()
            lb.textAlignment = .center
            lb.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        private lazy var countryImages: UIImageView = {
            let im = UIImageView()
            im.layer.cornerRadius = 32 / 2
            im.clipsToBounds = true
            im.translatesAutoresizingMaskIntoConstraints = false
            return im
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupCons()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupCons(){
            addSubview(labell)
            addSubview(countryImages)
            
            NSLayoutConstraint.activate([
                
                labell.centerYAnchor.constraint(equalTo: centerYAnchor),
                labell.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                countryImages.centerYAnchor.constraint(equalTo: centerYAnchor),
                countryImages.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                countryImages.heightAnchor.constraint(equalToConstant: 32),
                countryImages.widthAnchor.constraint(equalToConstant: 32),
                
            ])
            countryImages.layer.cornerRadius = 32 / 2
        }
        
        func setDates(dates: LanguagesStruct){
            labell.text = dates.label
            countryImages.image = UIImage(named: dates.image)
        }
        
    }
