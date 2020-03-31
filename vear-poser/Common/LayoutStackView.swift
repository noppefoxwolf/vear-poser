//
//  LayoutStackView.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/31.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit

class LayoutStackView: UIStackView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        } else {
            return hitView
        }
    }
}
