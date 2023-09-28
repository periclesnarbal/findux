//
//  HomeCollectionViewCell.swift
//  findux
//
//  Created by Péricles Narbal on 28/09/23.
//

import UIKit
import SwiftUI

class HomeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCollectionViewCell"
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commomInit()
    }
    
    private func commomInit() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.backgroundColor = .red
        contentView.addSubview(imageView)
        contentView.addSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -4),
            
            title.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 4),
            title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -4),
            
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        title.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func setupCell(data: HomeCellModel) {
        imageView.image = UIImage(named: data.imageName)
        title.text = data.title
    }
}

struct HomeCollectionViewCellPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            let dataModel = HomeCellModel(imageName: "findux", title: "test")
            let cell = HomeCollectionViewCell()
            cell.setupCell(data: dataModel)
            return cell
        }.previewLayout(.fixed(width: 120, height: 120))
    }
}
