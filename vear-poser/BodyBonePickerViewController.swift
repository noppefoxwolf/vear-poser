//
//  BodyBonePickerViewController.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/31.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import Closures
import VRMSceneKit

protocol BonePickerDelegate: class {
    func bonePicker(_ controller: BodyBonePickerViewController, selected bone: Humanoid.Bones)
}

class BodyBonePickerViewController: UIViewController, Embedable {
    static func make() -> BodyBonePickerViewController {
        UIStoryboard(name: "BodyBonePickerViewController", bundle: nil).instantiateInitialViewController()! as! BodyBonePickerViewController
    }
    weak var delegate: BonePickerDelegate? = nil
    @IBOutlet private weak var neckButton: UIButton!
    @IBOutlet private weak var rightSholderButton: UIButton!
    @IBOutlet private weak var leftSholderButton: UIButton!
    @IBOutlet private weak var rightUpperArmButton: UIButton!
    @IBOutlet private weak var leftUpperArmButton: UIButton!
    @IBOutlet private weak var upperChestButton: UIButton! /* いらんかも */
    @IBOutlet private weak var chestButton: UIButton!
    @IBOutlet private weak var spineButton: UIButton!
    @IBOutlet private weak var hipButton: UIButton!
    @IBOutlet private weak var rightLowerArmButton: UIButton!
    @IBOutlet private weak var leftLowerArmButton: UIButton!
    @IBOutlet private weak var rightHandButton: UIButton!
    @IBOutlet private weak var leftHandButton: UIButton!
    @IBOutlet private weak var rightUpperLegButton: UIButton!
    @IBOutlet private weak var leftUpperLegButton: UIButton!
    @IBOutlet private weak var rightLowerLegButton: UIButton!
    @IBOutlet private weak var leftLowerLegButton: UIButton!
    @IBOutlet private weak var rightFootButton: UIButton!
    @IBOutlet private weak var leftFootButton: UIButton!
    
    var buttons: [UIButton] {
        [neckButton, rightSholderButton, leftSholderButton, rightUpperArmButton, leftUpperArmButton,
         upperChestButton, chestButton, spineButton, hipButton, rightLowerArmButton, leftLowerArmButton,
         rightHandButton, leftHandButton, rightUpperLegButton, leftUpperLegButton, rightLowerLegButton,
         leftLowerLegButton, rightFootButton, leftFootButton].compactMap({ $0 })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.snp.makeConstraints({
            $0.width.equalTo(320)
            $0.height.equalTo(430)
        })
        
        buttons.forEach { (button) in
            button.onTap {
                self.select(button: button)
            }
        }
    }
    
    private func select(button: UIButton) {
        buttons.forEach({ $0.tintColor = .systemBlue })
        button.tintColor = .systemRed
        if let bone = bone(for: button) {
            delegate?.bonePicker(self, selected: bone)
        }
    }
    
    private func bone(for button: UIButton) -> Humanoid.Bones? {
        switch button {
        case neckButton:
            return .neck
        case rightSholderButton:
            return .rightShoulder
        case leftSholderButton:
            return .rightShoulder
        case rightUpperArmButton:
            return .rightUpperArm
        case leftUpperArmButton:
            return .leftUpperArm
        case upperChestButton:
            return .upperChest
        case spineButton:
            return .spine
        case hipButton:
            return .hips
        case rightLowerArmButton:
            return .rightLowerArm
        case leftLowerArmButton:
            return .leftLowerArm
        case rightHandButton:
            return .rightHand
        case leftHandButton:
            return .leftHand
        case rightUpperLegButton:
            return .rightUpperLeg
        case leftUpperLegButton:
            return .leftUpperLeg
        case rightLowerLegButton:
            return .rightLowerLeg
        case leftLowerLegButton:
            return .leftLowerLeg
        case rightFootButton:
            return .rightFoot
        case leftFootButton:
            return .leftFoot
        default:
            return nil
        }
    }
}

