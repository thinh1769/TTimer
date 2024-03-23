//
//  TTViewController.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import UIKit

public class TTViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func handleBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
