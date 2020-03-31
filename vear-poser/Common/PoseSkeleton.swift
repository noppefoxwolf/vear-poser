//
//  PoseSkeleton.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/31.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import simd
import VRMSceneKit
import SceneKit

struct PoseSkeleton: Codable {
    struct Quaternion: Codable {
        let x: Float
        let y: Float
        let z: Float
        let w: Float
        
        static var identity: Quaternion { Quaternion(x: 0, y: 0, z: 0, w: 1) }
    }
    let hips: Quaternion
    let leftUpperLeg: Quaternion
    let rightUpperLeg: Quaternion
    let leftLowerLeg: Quaternion
    let rightLowerLeg: Quaternion
    let leftFoot: Quaternion
    let rightFoot: Quaternion
    let spine: Quaternion
    let neck: Quaternion
    let head: Quaternion
    let leftShoulder: Quaternion
    let rightShoulder: Quaternion
    let leftUpperArm: Quaternion
    let rightUpperArm: Quaternion
    let leftLowerArm: Quaternion
    let rightLowerArm: Quaternion
    let leftHand: Quaternion
    let rightHand: Quaternion
    let leftToes: Quaternion
    let rightToes: Quaternion
    let leftEye: Quaternion
    let rightEye: Quaternion
    let jaw: Quaternion
    let leftThumbProximal: Quaternion
    let leftThumbIntermediate: Quaternion
    let leftThumbDistal: Quaternion
    let leftIndexProximal: Quaternion
    let leftIndexIntermediate: Quaternion
    let leftIndexDistal: Quaternion
    let leftMiddleProximal: Quaternion
    let leftMiddleIntermediate: Quaternion
    let leftMiddleDistal: Quaternion
    let leftRingProximal: Quaternion
    let leftRingIntermediate: Quaternion
    let leftRingDistal: Quaternion
    let leftLittleProximal: Quaternion
    let leftLittleIntermediate: Quaternion
    let leftLittleDistal: Quaternion
    let rightThumbProximal: Quaternion
    let rightThumbIntermediate: Quaternion
    let rightThumbDistal: Quaternion
    let rightIndexProximal: Quaternion
    let rightIndexIntermediate: Quaternion
    let rightIndexDistal: Quaternion
    let rightMiddleProximal: Quaternion
    let rightMiddleIntermediate: Quaternion
    let rightMiddleDistal: Quaternion
    let rightRingProximal: Quaternion
    let rightRingIntermediate: Quaternion
    let rightRingDistal: Quaternion
    let rightLittleProximal: Quaternion
    let rightLittleIntermediate: Quaternion
    let rightLittleDistal: Quaternion
    let upperChest: Quaternion
}

extension PoseSkeleton.Quaternion {
    var simd: simd_quatf {
        simd_quatf(ix: x, iy: y, iz: z, r: w)
    }
}

extension PoseSkeleton {
    func orientation(for bone: Humanoid.Bones) -> simd_quatf {
        switch bone {
        case .hips:
            return hips.simd
        case .leftUpperLeg:
            return leftUpperLeg.simd
        case .rightUpperLeg:
            return rightUpperLeg.simd
        case .leftLowerLeg:
            return leftLowerLeg.simd
        case .rightLowerLeg:
            return rightLowerLeg.simd
        case .leftFoot:
            return leftFoot.simd
        case .rightFoot:
            return rightFoot.simd
        case .spine:
            return spine.simd
        case .neck:
            return neck.simd
        case .head:
            return head.simd
        case .leftShoulder:
            return leftShoulder.simd
        case .rightShoulder:
            return rightShoulder.simd
        case .leftUpperArm:
            return leftUpperArm.simd
        case .rightUpperArm:
            return rightUpperArm.simd
        case .leftLowerArm:
            return leftLowerArm.simd
        case .rightLowerArm:
            return rightLowerArm.simd
        case .leftHand:
            return leftHand.simd
        case .rightHand:
            return rightHand.simd
        case .leftToes:
            return leftToes.simd
        case .rightToes:
            return rightToes.simd
        case .leftEye:
            return leftEye.simd
        case .rightEye:
            return rightEye.simd
        case .jaw:
            return jaw.simd
        case .leftThumbProximal:
            return leftThumbProximal.simd
        case .leftThumbIntermediate:
            return leftThumbIntermediate.simd
        case .leftThumbDistal:
            return leftThumbDistal.simd
        case .leftIndexProximal:
            return leftIndexProximal.simd
        case .leftIndexIntermediate:
            return leftIndexIntermediate.simd
        case .leftIndexDistal:
            return leftIndexDistal.simd
        case .leftMiddleProximal:
            return leftMiddleProximal.simd
        case .leftMiddleIntermediate:
            return leftMiddleIntermediate.simd
        case .leftMiddleDistal:
            return leftMiddleDistal.simd
        case .leftRingProximal:
            return leftRingProximal.simd
        case .leftRingIntermediate:
            return leftRingIntermediate.simd
        case .leftRingDistal:
            return leftRingDistal.simd
        case .leftLittleProximal:
            return leftLittleProximal.simd
        case .leftLittleIntermediate:
            return leftLittleIntermediate.simd
        case .leftLittleDistal:
            return leftLittleDistal.simd
        case .rightThumbProximal:
            return rightThumbProximal.simd
        case .rightThumbIntermediate:
            return rightThumbIntermediate.simd
        case .rightThumbDistal:
            return rightThumbDistal.simd
        case .rightIndexProximal:
            return rightIndexProximal.simd
        case .rightIndexIntermediate:
            return rightIndexIntermediate.simd
        case .rightIndexDistal:
            return rightIndexDistal.simd
        case .rightMiddleProximal:
            return rightMiddleProximal.simd
        case .rightMiddleIntermediate:
            return rightMiddleIntermediate.simd
        case .rightMiddleDistal:
            return rightMiddleDistal.simd
        case .rightRingProximal:
            return rightRingProximal.simd
        case .rightRingIntermediate:
            return rightRingIntermediate.simd
        case .rightRingDistal:
            return rightRingDistal.simd
        case .rightLittleProximal:
            return rightLittleProximal.simd
        case .rightLittleIntermediate:
            return rightLittleIntermediate.simd
        case .rightLittleDistal:
            return rightLittleDistal.simd
        case .upperChest:
            return upperChest.simd
        }
    }
}

extension SCNQuaternion {
    var toSerializable: PoseSkeleton.Quaternion {
        PoseSkeleton.Quaternion(x: x, y: y, z: z, w: w)
    }
}

extension PoseSkeleton {
    init(node: VRMNode) {
        
        self.init(
            hips: node.humanoid.node(for: .hips)?.orientation.toSerializable ?? .identity,
            leftUpperLeg: node.humanoid.node(for: .leftUpperLeg)?.orientation.toSerializable ?? .identity,
            rightUpperLeg: node.humanoid.node(for: .rightUpperLeg)?.orientation.toSerializable ?? .identity,
            leftLowerLeg: node.humanoid.node(for: .leftLowerLeg)?.orientation.toSerializable ?? .identity,
            rightLowerLeg: node.humanoid.node(for: .rightLowerLeg)?.orientation.toSerializable ?? .identity,
            leftFoot: node.humanoid.node(for: .leftFoot)?.orientation.toSerializable ?? .identity,
            rightFoot: node.humanoid.node(for: .rightFoot)?.orientation.toSerializable ?? .identity,
            spine: node.humanoid.node(for: .spine)?.orientation.toSerializable ?? .identity,
            neck: node.humanoid.node(for: .neck)?.orientation.toSerializable ?? .identity,
            head: node.humanoid.node(for: .head)?.orientation.toSerializable ?? .identity,
            leftShoulder: node.humanoid.node(for: .leftShoulder)?.orientation.toSerializable ?? .identity,
            rightShoulder: node.humanoid.node(for: .rightShoulder)?.orientation.toSerializable ?? .identity,
            leftUpperArm: node.humanoid.node(for: .leftUpperArm)?.orientation.toSerializable ?? .identity,
            rightUpperArm: node.humanoid.node(for: .rightUpperArm)?.orientation.toSerializable ?? .identity,
            leftLowerArm: node.humanoid.node(for: .leftLowerArm)?.orientation.toSerializable ?? .identity,
            rightLowerArm: node.humanoid.node(for: .rightLowerArm)?.orientation.toSerializable ?? .identity,
            leftHand: node.humanoid.node(for: .leftHand)?.orientation.toSerializable ?? .identity,
            rightHand: node.humanoid.node(for: .rightHand)?.orientation.toSerializable ?? .identity,
            leftToes: node.humanoid.node(for: .leftToes)?.orientation.toSerializable ?? .identity,
            rightToes: node.humanoid.node(for: .rightToes)?.orientation.toSerializable ?? .identity,
            leftEye: node.humanoid.node(for: .leftEye)?.orientation.toSerializable ?? .identity,
            rightEye: node.humanoid.node(for: .rightEye)?.orientation.toSerializable ?? .identity,
            jaw: node.humanoid.node(for: .jaw)?.orientation.toSerializable ?? .identity,
            leftThumbProximal: node.humanoid.node(for: .leftThumbProximal)?.orientation.toSerializable ?? .identity,
            leftThumbIntermediate: node.humanoid.node(for: .leftThumbIntermediate)?.orientation.toSerializable ?? .identity,
            leftThumbDistal: node.humanoid.node(for: .leftThumbDistal)?.orientation.toSerializable ?? .identity,
            leftIndexProximal: node.humanoid.node(for: .leftIndexProximal)?.orientation.toSerializable ?? .identity,
            leftIndexIntermediate: node.humanoid.node(for: .leftIndexIntermediate)?.orientation.toSerializable ?? .identity,
            leftIndexDistal: node.humanoid.node(for: .leftIndexDistal)?.orientation.toSerializable ?? .identity,
            leftMiddleProximal: node.humanoid.node(for: .leftMiddleProximal)?.orientation.toSerializable ?? .identity,
            leftMiddleIntermediate: node.humanoid.node(for: .leftMiddleIntermediate)?.orientation.toSerializable ?? .identity,
            leftMiddleDistal: node.humanoid.node(for: .leftMiddleDistal)?.orientation.toSerializable ?? .identity,
            leftRingProximal: node.humanoid.node(for: .leftRingProximal)?.orientation.toSerializable ?? .identity,
            leftRingIntermediate: node.humanoid.node(for: .leftRingIntermediate)?.orientation.toSerializable ?? .identity,
            leftRingDistal: node.humanoid.node(for: .leftRingDistal)?.orientation.toSerializable ?? .identity,
            leftLittleProximal: node.humanoid.node(for: .leftLittleProximal)?.orientation.toSerializable ?? .identity,
            leftLittleIntermediate: node.humanoid.node(for: .leftLittleIntermediate)?.orientation.toSerializable ?? .identity,
            leftLittleDistal: node.humanoid.node(for: .leftLittleDistal)?.orientation.toSerializable ?? .identity,
            rightThumbProximal: node.humanoid.node(for: .rightThumbProximal)?.orientation.toSerializable ?? .identity,
            rightThumbIntermediate: node.humanoid.node(for: .rightThumbIntermediate)?.orientation.toSerializable ?? .identity,
            rightThumbDistal: node.humanoid.node(for: .rightThumbDistal)?.orientation.toSerializable ?? .identity,
            rightIndexProximal: node.humanoid.node(for: .rightIndexProximal)?.orientation.toSerializable ?? .identity,
            rightIndexIntermediate: node.humanoid.node(for: .rightIndexIntermediate)?.orientation.toSerializable ?? .identity,
            rightIndexDistal: node.humanoid.node(for: .rightIndexDistal)?.orientation.toSerializable ?? .identity,
            rightMiddleProximal: node.humanoid.node(for: .rightMiddleProximal)?.orientation.toSerializable ?? .identity,
            rightMiddleIntermediate: node.humanoid.node(for: .rightMiddleIntermediate)?.orientation.toSerializable ?? .identity,
            rightMiddleDistal: node.humanoid.node(for: .rightMiddleDistal)?.orientation.toSerializable ?? .identity,
            rightRingProximal: node.humanoid.node(for: .rightRingProximal)?.orientation.toSerializable ?? .identity,
            rightRingIntermediate: node.humanoid.node(for: .rightRingIntermediate)?.orientation.toSerializable ?? .identity,
            rightRingDistal: node.humanoid.node(for: .rightRingDistal)?.orientation.toSerializable ?? .identity,
            rightLittleProximal: node.humanoid.node(for: .rightLittleProximal)?.orientation.toSerializable ?? .identity,
            rightLittleIntermediate: node.humanoid.node(for: .rightLittleIntermediate)?.orientation.toSerializable ?? .identity,
            rightLittleDistal: node.humanoid.node(for: .rightLittleDistal)?.orientation.toSerializable ?? .identity,
            upperChest: node.humanoid.node(for: .upperChest)?.orientation.toSerializable ?? .identity
        )
    }
}
