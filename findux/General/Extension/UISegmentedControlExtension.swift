//
//  UISegmentedControlExtension.swift
//  findux
//
//  Created by Péricles Narbal on 23/11/23.
//

import UIKit

extension UISegmentedControl {
    func getTitle() -> String {
        let selectedIndex = self.selectedSegmentIndex
        return self.titleForSegment(at: selectedIndex) ?? ""
    }
}


