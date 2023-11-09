//
//  SimulatorView.swift
//  findux
//
//  Created by Péricles Narbal on 30/10/23.
//

import UIKit
import SwiftUI

class SimulatorView: BaseView<SimulatorCoordinator> {
    
    lazy var menus = [SimulatorCellModel(imageName: "Calendar", title: "Financiamento") {},
                      SimulatorCellModel(imageName: "Percent", title: "Investimento") {}]
    
    let collectionView: UICollectionView = {
        let layout = SimulatorCollectionLayout()
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
        addSubview(collectionView)
        embedConstraints(collectionView, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        
        collectionView.register(SimulatorCollectionViewCell.self, forCellWithReuseIdentifier: SimulatorCollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SimulatorView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulatorCollectionViewCell.reuseIdentifier, for: indexPath) as? SimulatorCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(data: menus[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = menus[indexPath.row]
        menuItem.action()
    }
}


extension SimulatorView: FullAccessViewControllerDelegate {
    func getNavigationController(_ navigationController: UINavigationController?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.title = "Simuladores"
    }
}

struct SimulatorViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SimulatorView()
        }.edgesIgnoringSafeArea(.all)
    }
}
