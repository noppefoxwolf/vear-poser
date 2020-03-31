//
//  BoneSelectorViewController.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/31.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import SFSafeSymbols
import VRMSceneKit

protocol BoneSelectorViewControllerDelegate: class {
    func boneSelector(_ controller: BoneSelectorViewController, selected bone: Humanoid.Bones)
    func boneSelector(_ controller: BoneSelectorViewController, changedX value: Float)
    func boneSelector(_ controller: BoneSelectorViewController, changedY value: Float)
    func boneSelector(_ controller: BoneSelectorViewController, changedZ value: Float)
    func didTapExportButton(_ controller: BoneSelectorViewController)
    func didTapImportButton(_ controller: BoneSelectorViewController)
}

class BoneSelectorNavigationController: UINavigationController {
    var boneSelectorViewController: BoneSelectorViewController { viewControllers.first as! BoneSelectorViewController }
}

class BoneSelectorViewController: UIViewController {
    private let pickerView: ContainerView<BodyBonePickerViewController> = .init()
    private let segmentedControl: UISegmentedControl = .init(items: ["Body","Head","Left H","Right H"])
    private let backButton: UIButton = .init(type: .system)
    private let xSlider: UISlider = .init()
    private let ySlider: UISlider = .init()
    private let zSlider: UISlider = .init()
    weak var delegate: BoneSelectorViewControllerDelegate? = nil
    
    override func loadView() {
        super.loadView()
        
        segmentedControl.selectedSegmentIndex = 0
        xSlider.tintColor = .red
        ySlider.tintColor = .green
        zSlider.tintColor = .blue
        backButton.setTitle("Undo", for: .normal)
        
        let stackView: UIStackView
        Slider: do {
            let sliders: [UISlider] = [xSlider, ySlider, zSlider]
            sliders.forEach {
                $0.minimumValue = -.pi
                $0.maximumValue = .pi
            }
            stackView = UIStackView(arrangedSubviews: [segmentedControl] + sliders + [backButton])
            stackView.axis = .vertical
            stackView.spacing = 12
            view.addSubview(stackView)
            stackView.snp.makeConstraints({
                $0.left.bottom.right.equalToSuperview().inset(20)
            })
        }
        
        Picker: do {
            view.addSubview(pickerView)
            pickerView.snp.makeConstraints({
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(stackView.snp.top).inset(-20)
            })
            let vc = BodyBonePickerViewController.make()
            vc.delegate = self
            pickerView.embed(vc, parent: self)
        }
        
        Navigation: do {
            let importButton = UIBarButtonItem(image: .init(systemSymbol: .squareAndArrowDown), style: .done) {
                self.delegate?.didTapImportButton(self)
            }
            let exportButton = UIBarButtonItem(image: .init(systemSymbol: .squareAndArrowUp), style: .done) {
                self.delegate?.didTapExportButton(self)
            }
            navigationItem.rightBarButtonItems = [exportButton, importButton]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xSlider.onChange(handler: { self.delegate?.boneSelector(self, changedX: $0) })
        ySlider.onChange(handler: { self.delegate?.boneSelector(self, changedY: $0) })
        zSlider.onChange(handler: { self.delegate?.boneSelector(self, changedZ: $0) })
    }
    
    func configure(eularAngle: SIMD3<Float>) {
        xSlider.setValue(eularAngle.x, animated: false)
        ySlider.setValue(eularAngle.y, animated: false)
        zSlider.setValue(eularAngle.z, animated: false)
    }
}

extension BoneSelectorViewController: BonePickerDelegate {
    func bonePicker(_ controller: BodyBonePickerViewController, selected bone: Humanoid.Bones) {
        delegate?.boneSelector(self, selected: bone)
    }
}
