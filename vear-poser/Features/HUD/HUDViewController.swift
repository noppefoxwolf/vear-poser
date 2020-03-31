//
//  HUDViewController.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/31.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit

class HUDViewController: UIViewController {
    private let effectView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .systemMaterial))
    private let indicatorView: UIActivityIndicatorView = .init(style: .medium)
    private let label: UILabel = .init(frame: .zero)
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .clear
        
        view.addSubview(effectView)
        effectView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        let stackView = UIStackView(arrangedSubviews: [indicatorView, label])
        stackView.spacing = 10
        effectView.contentView.addSubview(stackView)
        stackView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(20) })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.startAnimating()
        label.text = "自動保存中..."
    }
}
