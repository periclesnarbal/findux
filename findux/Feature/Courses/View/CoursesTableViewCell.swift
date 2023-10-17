//
//  CoursesCollectionViewCell.swift
//  findux
//
//  Created by Péricles Narbal on 17/10/23.
//

import UIKit
import SwiftUI

class CoursesTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CoursesTableViewCell"
    
    typealias Closure = () -> Void
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goToCourseLinkButton: LinkButtonLabel!
    
    var action: Closure?
    
    lazy var xibView: UIView = {
        let view = loadViewFromNib()
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view ?? UIView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(xibView)
        
        goToCourseLinkButton.action = { [weak self] in
            self?.action?()
        }
    }
    
    func setupConstraints() {
        contentView.embedConstraints(xibView)
    }
    
    func setupCell(data: CoursesCellModel) {
        titleLabel.text = data.title
        authorLabel.text = data.author
        descriptionLabel.text = data.description
        action = data.action
    }
}

struct CoursesTableViewCellPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            CoursesTableViewCell()
        }.edgesIgnoringSafeArea(.all)
    }
}
