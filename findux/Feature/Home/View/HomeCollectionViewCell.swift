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
        backgroundColor = .clear
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 12
        contentView.addSubview(imageView)
        contentView.addSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(lessThanOrEqualTo: contentView.centerYAnchor, constant: -12),
            
            title.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
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
            let dataModel = HomeCellModel(imageName: "Book", title: "Cursos")
            let cell = HomeCollectionViewCell()
            cell.setupCell(data: dataModel)
            return cell
        }.previewLayout(.fixed(width: 120, height: 120))
    }
}
