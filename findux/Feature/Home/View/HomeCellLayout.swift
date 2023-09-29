//
//  HomeCellLayout.swift
//  findux
//
//  Created by Péricles Narbal on 29/09/23.
//

import UIKit
import SwiftUI

class HomeCollectionLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        // Definir o tamanho dos itens (itens quadrados)
        let collectionWidth = UIScreen.main.bounds.width
        let horizontalPadding = CGFloat(32)
        let itensForRow = CGFloat(2)
        let itemSize = (collectionWidth - (horizontalPadding * 2) - ((itensForRow - 1) * 12.00000000000001)) / itensForRow // Considerando 16px de margens laterais e 8px de espaçamento entre itens
        self.itemSize = CGSize(width: itemSize, height: itemSize)
        
        // Definir o espaçamento mínimo entre as linhas e entre os itens na mesma linha
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
        
        sectionInset = UIEdgeInsets(top: 0, left: horizontalPadding, bottom: 0, right: horizontalPadding)
        
        // Definir a direção de rolagem (vertical)
        scrollDirection = .vertical
    }
}

struct HomeCollectionLayoutPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            HomeView()
        }.edgesIgnoringSafeArea(.all)
    }
}
