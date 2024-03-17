//
//  TTViewController.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import UIKit

class TTViewController: UIViewController {
    private lazy var blurView = makeBlurView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addBlurEffect() {
        blurView.frame = self.view.bounds
        view.addSubview(blurView)
    }
    
    func removeBlurEffect() {
        blurView.removeFromSuperview()
    }
}

extension TTViewController {
    private func makeBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let v = UIVisualEffectView(effect: blurEffect)
        return v
    }
}
