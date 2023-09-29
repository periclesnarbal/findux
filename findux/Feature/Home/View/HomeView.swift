//
//  HomeView.swift
//  findux
//
//  Created by Péricles Narbal on 25/08/23.
//

import UIKit
import SwiftUI

class HomeView: BaseView<HomeCoordinator> {
    
    let menus = [HomeCellModel(imageName: "Book", title: "Cursos"),
                 HomeCellModel(imageName: "OpenBook", title: "Glossário"),
                 HomeCellModel(imageName: "Chart", title: "Simulador"),
                 HomeCellModel(imageName: "Calendar", title: "Projetos"),
                 HomeCellModel(imageName: "Percent", title: "Investimentos"),
                 HomeCellModel(imageName: "Chart_alt", title: "Bolsa de valores")]
    
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
        self.addSubview(collectionView)
        self.embedConstraints(collectionView)
        
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
}

//extension HomeView: LifeCycleViewControllerDelegate {
//    func viewDidLoad() {
//        backgroundColor = .red
//    }
//}
//
//extension HomeView: FullAccessViewControllerDelegate {
//    func getNavigationItem(_ navigationItem: UINavigationItem) {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToPasswordViewController))
//    }
//
//    @objc
//    func goToHomeTwoViewController() {
//        coordinatorDelegate?.goToHomeTwoViewController()
//    }
//
//    @objc
//    func goToPasswordViewController() {
//        coordinatorDelegate?.goToPassword()
//    }
//}

struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            HomeView()
        }.edgesIgnoringSafeArea(.all)
    }
}
