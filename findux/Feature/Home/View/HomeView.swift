//
//  HomeView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit
import SwiftUI

class HomeView: BaseView<HomeCoordinator> {
    
    lazy var menus = [HomeCellModel(imageName: "Book", title: "Cursos") { [weak self] in
        self?.coordinatorDelegate?.goToCourses() },
                      HomeCellModel(imageName: "OpenBook", title: "Glossário") {},
                      HomeCellModel(imageName: "Chart", title: "Simulador") {},
                      HomeCellModel(imageName: "Calendar", title: "Projetos") {},
                      HomeCellModel(imageName: "Percent", title: "Investimentos") {},
                      HomeCellModel(imageName: "Chart_alt", title: "Bolsa de valores") {}]
    
    let headerImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .darkGray
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = HomeCollectionLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    func commomInit() {
        backgroundColor = .white
        self.addSubview(headerImageView)
        self.addSubview(profileButton)
        self.addSubview(collectionView)
        
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        headerImageView.image = UIImage(named: "findux")
        profileButton.setImage(UIImage(systemName: "person"), for: .normal)
        
        profileButton.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            headerImageView.widthAnchor.constraint(equalToConstant: 200),
            headerImageView.heightAnchor.constraint(equalToConstant: 30),
            
            profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileButton.widthAnchor.constraint(equalToConstant: 28),
            profileButton.heightAnchor.constraint(equalToConstant: 24),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func profileButtonAction() {
        coordinatorDelegate?.openProfileModal()
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(data: menus[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = menus[indexPath.row]
        menuItem.action()
    }
}

extension HomeView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            HomeView()
        }.edgesIgnoringSafeArea(.all)
    }
}
