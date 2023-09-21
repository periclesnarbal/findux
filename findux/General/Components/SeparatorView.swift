//
//  SeparatorView.swift
//  findux
//
//  Created by Péricles Narbal on 08/09/23.
//

import SwiftUI
import UIKit

class SeparatorView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    private let separatorLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorRightView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .systemGray
        return label
    }()
    
    private(set) lazy var separatorLineHeight: NSLayoutConstraint = {
        let constraint = separatorLeftView.heightAnchor.constraint(equalToConstant: weight)
        return constraint
    }()
    
    private(set) lazy var separatorLineWidth: NSLayoutConstraint = {
        let constraint = separatorLeftView.widthAnchor.constraint(equalToConstant: weight)
        return constraint
    }()
    
    var weight: CGFloat = 2 {
        didSet {
            changeLineWeight(weight)
        }
    }
    
    var axis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            changeAxis(axis)
        }
    }
    
    var textSpacing: CGFloat = 8 {
        didSet {
            stackView.spacing = textSpacing
        }
    }
    
    var color: UIColor = .systemGray4 {
        didSet {
            changeColor(color)
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
        addSubview(stackView)
        stackView.addArrangedSubview(separatorLeftView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(separatorRightView)
    }
    
    private func setupConstraints() {
        backgroundColor = .clear
        embedConstraints(stackView)
        
        separatorLineHeight.isActive = true
        
        NSLayoutConstraint.activate([
            separatorRightView.heightAnchor.constraint(equalTo: separatorLeftView.heightAnchor),
            separatorRightView.widthAnchor.constraint(equalTo: separatorLeftView.widthAnchor)
        ])
    }
    
    private func changeLineHeight(_ height: CGFloat) {
        separatorLineHeight.isActive = false
        separatorLineHeight.constant = height
        separatorLineHeight.isActive = true
    }
    
    private func changeLineWidth(_ width: CGFloat) {
        separatorLineWidth.isActive = false
        separatorLineWidth.constant = width
        separatorLineWidth.isActive = true
    }
    
    private func changeLineWeight(_ weight: CGFloat) {
        switch axis {
        case .horizontal:
            changeLineHeight(weight)
        case.vertical:
            changeLineWidth(weight)
        @unknown default:
            break
        }
    }
    
    private func changeAxis(_ axis: NSLayoutConstraint.Axis) {
        switch axis {
        case .horizontal:
            separatorLineWidth.isActive = false
            changeLineHeight(weight)
        case .vertical:
            separatorLineHeight.isActive = false
            changeLineWidth(weight)
        @unknown default:
            break
        }
        
        stackView.axis = axis
    }
    
    private func changeColor(_ color: UIColor) {
        separatorLeftView.backgroundColor = color
        separatorRightView.backgroundColor = color
    }
}

struct SeparatorViewPreview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            let separator = SeparatorView()
            separator.textSpacing = 10
            separator.axis = .vertical
            separator.label.text = "Abel"
            separator.weight = 2
            separator.color = .blue
            return separator
        }.edgesIgnoringSafeArea(.all)
    }
}

