//
//  ViewController.swift
//  vear-poser
//
//  Created by Tomoya Hirano on 2020/03/30.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import VRMSceneKit
import SnapKit

final class ViewController: UIViewController {
    private let boneSelectorView: ContainerView<BoneSelectorNavigationController> = .init()
    private let previewView: ContainerView<PreviewViewController> = .init()
    private let hudView: ContainerView<HUDViewController> = .init()
    
    override func loadView() {
        super.loadView()
        view.addSubview(boneSelectorView)
        view.addSubview(previewView)
        view.addSubview(hudView)
        
        BoneSelector: do {
            boneSelectorView.snp.makeConstraints({
                $0.width.equalTo(320)
                $0.top.left.bottom.equalToSuperview()
            })
        }
        
        Preview: do {
            previewView.snp.makeConstraints({
                $0.top.right.bottom.equalToSuperview()
                $0.left.equalTo(boneSelectorView.snp.right)
            })
            let vc = BoneSelectorViewController()
            let nc = BoneSelectorNavigationController(rootViewController: vc)
            vc.delegate = self
            boneSelectorView.embed(nc, parent: self)
            previewView.embed(PreviewViewController(), parent: self)
        }
        
        HUD: do {
            hudView.snp.makeConstraints({
                $0.right.bottom.equalToSuperview().inset(20)
            })
            hudView.embed(HUDViewController(), parent: self)
            hudView.backgroundColor = .clear
            hudView.layer.cornerRadius = 6.0
            hudView.layer.masksToBounds = true
            hudView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: BoneSelectorViewControllerDelegate {
    func boneSelector(_ controller: BoneSelectorViewController, changedX value: Float) {
        previewView.content?.setEularX(value)
    }
    
    func boneSelector(_ controller: BoneSelectorViewController, changedY value: Float) {
        previewView.content?.setEularY(value)
    }
    
    func boneSelector(_ controller: BoneSelectorViewController, changedZ value: Float) {
        previewView.content?.setEularZ(value)
    }
    
    func boneSelector(_ controller: BoneSelectorViewController, selected bone: Humanoid.Bones) {
        previewView.content?.setSelected(bone: bone)
        if let node = previewView.content?.node(for: bone) {
            boneSelectorView.content?.boneSelectorViewController.configure(eularAngle: node.simdEulerAngles)
        }
    }
    
    func didTapExportButton(_ controller: BoneSelectorViewController) {
        guard let pose = previewView.content?.generatePoseSkeleton() else { return }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pose)
            let url = URL(fileURLWithPath: NSTemporaryDirectory() + "/\(UUID().uuidString).json")
            try data.write(to: url)
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            vc.popoverPresentationController?.sourceView = controller.navigationController?.navigationBar
            present(vc, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    func didTapImportButton(_ controller: BoneSelectorViewController) {
        let vc = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        vc.popoverPresentationController?.sourceView = controller.navigationController?.navigationBar
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        PoseDocument(fileURL: url).open { (_) in
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let pose = try decoder.decode(PoseSkeleton.self, from: data)
                DispatchQueue.main.async {
                    self.previewView.content?.configure(pose: pose)
                }
            } catch {
                print(error)
            }
        }
    }
}

class PoseDocument: UIDocument {
    override func open(completionHandler: ((Bool) -> Void)? = nil) {
        completionHandler?(true)
    }
}
