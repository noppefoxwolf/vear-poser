//
//  PreviewViewController.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/31.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import SceneKit
import VRMSceneKit
import SnapKit

class PreviewViewController: UIViewController, Embedable {
    private let scnView: SCNView = .init(frame: .zero)
    private var selectedBone: Humanoid.Bones? = nil
    private var vrmScene: VRMScene { scnView.scene as! VRMScene }
    override func loadView() {
        super.loadView()
        view.addSubview(scnView)
        scnView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        scnView.allowsCameraControl = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = try! VRMSceneLoader(named: "AliciaSolid.vrm")
        let scene = try! loader.loadScene()
        scene.background.contents = UIColor.systemGray6
        scnView.scene = scene
    }
    
    func setSelected(bone: Humanoid.Bones?) {
        selectedBone = bone
    }
    
    func setEularX(_ value: Float) {
        guard let selectedBone = selectedBone else { return }
        node(for: selectedBone)?.eulerAngles.x = value
    }
    
    func setEularY(_ value: Float) {
        guard let selectedBone = selectedBone else { return }
        node(for: selectedBone)?.eulerAngles.y = value
    }
    
    func setEularZ(_ value: Float) {
        guard let selectedBone = selectedBone else { return }
        node(for: selectedBone)?.eulerAngles.z = value
    }
    
    func node(for bone: Humanoid.Bones) -> SCNNode? {
        vrmScene.vrmNode.humanoid.node(for: bone)
    }
    
    func generatePoseSkeleton() -> PoseSkeleton {
        PoseSkeleton(node: vrmScene.vrmNode)
    }
    
    func configure(pose: PoseSkeleton) {
        let humanoid = vrmScene.vrmNode.humanoid
        Humanoid.Bones.allCases.forEach { (bone) in
            humanoid.node(for: bone)?.simdOrientation = pose.orientation(for: bone)
        }
    }
}

