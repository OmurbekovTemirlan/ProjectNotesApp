//
//  HomeNotesCollectionViewCell.swift
//  ProjectNotesApp
//
//  Created by Apple on 15.3.2024.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    
    static var cellId = "cellId"
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "School Notes"
        view.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstriants()
        backgroundColor = .systemBlue
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String){
        titleLabel.text = title
    }
    
    private func setupConstriants(){
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
