//
//  FirstVIew.swift
//  ProjectNotesApp
//
//  Created by Apple on 18.3.2024.
//

import UIKit

protocol OnBordingViewProtocol: AnyObject{
    
}

class OnBordingView: UIViewController {
    
    var conttroller: FirstViewControllerProtocol?
    
    
    
    var currentPagess: Int = 0
    
    
    
    
    private lazy var OnBordingStucts: [OnBordingStruct] = [OnBordingStruct(image: "firstImage",
                                                                           biglabel: "Welcome to The Note",
                                                                           liitleLabel: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"),
                                                           OnBordingStruct(image: "seccondImage",
                                                                           biglabel: "Set Up Your Profile",
                                                                           liitleLabel: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
                                                           
                                                           OnBordingStruct(image: "thirdImage",
                                                                           biglabel: "Dive into The Note",
                                                                           liitleLabel: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")]
    
    private lazy var OnBordingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
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
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        view.layer.cornerRadius = 12
        view.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uipageControll: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = OnBordingStucts.count
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
        view.addSubview(OnBordingCollectionView)
        view.addSubview(skipBtn)
        view.addSubview(nextBtn)
        view.addSubview(uipageControll)
        NSLayoutConstraint.activate([
            OnBordingCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            OnBordingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            OnBordingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            OnBordingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
        
        OnBordingCollectionView.dataSource = self
        OnBordingCollectionView.delegate = self
        OnBordingCollectionView.register(OnBordingCell.self, forCellWithReuseIdentifier: OnBordingCell.cellId)
    }
    
    @objc private func nextButtonTapped(_ sender: Any) {
        if currentPagess == 1 {
            UserDefaults.standard.set(true, forKey: "IsOnBord")
        }
        
        if currentPagess < OnBordingStucts.count - 1 {
            currentPagess += 1
            scrollToCurrentPage(animated: true)
        } else {
            transitionToHomeView()
        }
        
        test()
    }
    
    private func scrollToCurrentPage(animated: Bool) {
        let indexPath = IndexPath(item: currentPagess, section: 0)
        OnBordingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        uipageControll.currentPage = currentPagess
    }
    
    func test() {
        
        guard OnBordingStucts.count > uipageControll.currentPage + 0 else { return }
        
        OnBordingCollectionView.isPagingEnabled = false
        
        OnBordingCollectionView.scrollToItem(at: IndexPath(item: uipageControll.currentPage + 0, section: 0), at: .centeredHorizontally, animated: true)
        
        OnBordingCollectionView.isPagingEnabled = true
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


extension OnBordingView: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        OnBordingStucts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBordingCell.cellId, for: indexPath) as! OnBordingCell
        cell.configure(with: OnBordingStucts[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        uipageControll.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}

extension OnBordingView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}



