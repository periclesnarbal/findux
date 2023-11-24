//
//  SimulatorCellModel.swift
//  findux
//
//  Created by Péricles Narbal on 09/11/23.
//

import Foundation

struct SimulatorCellModel {
    let imageName: String
    let title: String
    let isEnabled: Bool
    let action: () -> Void
}
