//
//  FirstViewCell.swift
//  ProjectNotesApp
//
//  Created by Apple on 18.3.2024.
//

import UIKit


struct OnBordingStruct{
    var image: String
    var biglabel: String
    var liitleLabel: String
}


class OnBordingCell: UICollectionViewCell {
    
    static let cellId = "cell"
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
   
    private lazy var bigLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var littleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.numberOfLines = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(image)
        contentView.addSubview(bigLabel)
        contentView.addSubview(littleLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 212),
            
            
            bigLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            bigLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bigLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bigLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            littleLabel.topAnchor.constraint(equalTo: bigLabel.bottomAnchor, constant: 16),
            littleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            littleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            littleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
    }

    
    func configure(with: OnBordingStruct){
        image.image = UIImage(named: with.image)
        bigLabel.text = with.biglabel
        littleLabel.text = with.liitleLabel
    }
}
