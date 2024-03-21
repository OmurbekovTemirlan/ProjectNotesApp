//
//  FirstVIew.swift
//  ProjectNotesApp
//
//  Created by Apple on 18.3.2024.
//

import UIKit

protocol FirstViewProtocol: AnyObject{
    
}

class FirstVIew: UIViewController {
  
    var conttroller: FirstViewControllerProtocol?
    
   
    
        var currentPagess: Int = 0
 

   
    
    private lazy var informationsDatas: [FirstViewStruct] = [FirstViewStruct(image: "firstImage",
                                                                 biglabel: "Welcome to The Note",
                                                                 liitleLabel: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"),
                                                  FirstViewStruct(image: "seccondImage",
                                                        biglabel: "Set Up Your Profile",
                                                        liitleLabel: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
                                                  
                                                  FirstViewStruct(image: "thirdImage",
                                                                 biglabel: "Dive into The Note",
                                                                 liitleLabel: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")]
    
    private lazy var welcomeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()

    
    private lazy var skipBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.backgroundColor = UIColor(named: "BackraundColor")
        view.setTitleColor(UIColor(named: "OtherColor"), for: .normal)
        view.addTarget(self, action: #selector(skipBtnTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) /*UIColor(hex: "#FF3D3D" )*/
        view.layer.cornerRadius = 12
        view.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uipageControll: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = informationsDatas.count
        view.pageIndicatorTintColor = .gray
        view.currentPageIndicatorTintColor =  UIColor(named: "OtherColor")
        view.hidesForSinglePage = false
        view.backgroundStyle = .automatic
        view.addTarget(self, action: #selector(nextButtonTapped), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        
    }

    private func setupConstraints(){
        view.addSubview(welcomeCollectionView)
        view.addSubview(skipBtn)
        view.addSubview(nextBtn)
        view.addSubview(uipageControll)
        NSLayoutConstraint.activate([
            welcomeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            welcomeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            skipBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            skipBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipBtn.heightAnchor.constraint(equalToConstant: 40),
            skipBtn.widthAnchor.constraint(equalToConstant: 160),
            
            nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextBtn.heightAnchor.constraint(equalToConstant: 40),
            nextBtn.widthAnchor.constraint(equalToConstant: 160),
            
            uipageControll.topAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -130),
            uipageControll.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        welcomeCollectionView.dataSource = self
        welcomeCollectionView.delegate = self
        welcomeCollectionView.register(FirstViewCell.self, forCellWithReuseIdentifier: FirstViewCell.cellId)
    }
    
    @objc private func nextButtonTapped(_ seender: Any) {
            UserDefaults.standard.set(true, forKey: "IsOnBord")
            if currentPagess < informationsDatas.count - 1 {
                currentPagess += 1
                scrollToCurrentPage(animated: true)
            } else {
                transitionToHomeView()
            }
        
        }
        
    private func scrollToCurrentPage(animated: Bool) {
        let indexPath = IndexPath(item: currentPagess, section: 0)
        welcomeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        uipageControll.currentPage = currentPagess
    }

        
        private func transitionToHomeView() {
            let vc = HomeView()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    
    

    @objc private func skipBtnTapped(_ sender: UIButton){
        let vc = HomeView()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension FirstVIew: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        informationsDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstViewCell.cellId, for: indexPath) as! FirstViewCell
        cell.configure(with: informationsDatas[indexPath.row])
       
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        uipageControll.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
    
}
extension FirstVIew: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    }



