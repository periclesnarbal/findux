//
//  SimulatorCollectionViewCell.swift
//  findux
//
//  Created by Péricles Narbal on 09/11/23.
//

import UIKit
import SwiftUI

class SimulatorCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SimulatorCollectionViewCell"
    
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
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isEnabled: Bool = true {
        didSet {
            switch isEnabled {
            case true: overlayView.isHidden = true
            case false: overlayView.isHidden = false
            }
        }
    }
    
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
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(overlayView)
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
        
        contentView.embedConstraints(overlayView)
    }
    
    func setupCell(data: SimulatorCellModel) {
        imageView.image = UIImage(named: data.imageName)
        title.text = data.title
        isEnabled = data.isEnabled
    }
}

struct SimulatorCollectionViewCellPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            let dataModel = SimulatorCellModel(imageName: "Book", title: "Cursos", isEnabled: true) {}
            let cell = SimulatorCollectionViewCell()
            cell.setupCell(data: dataModel)
            return cell
        }.previewLayout(.fixed(width: 120, height: 120))
    }
}
