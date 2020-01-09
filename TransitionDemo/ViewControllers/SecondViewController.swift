//
//  SecondViewController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let edgePanGesture = UIScreenEdgePanGestureRecognizer()
    var navigationDelegate: NavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        edgePanGesture.edges = .left
        edgePanGesture.addTarget(self, action: #selector(onEdgePan(gesture:)))
        view.addGestureRecognizer(edgePanGesture)
    }

    @objc func onEdgePan(gesture: UIScreenEdgePanGestureRecognizer) {
        let v = self.view.hitTest(gesture.location(in: gesture.view), with: nil)
        
        let translationX =  gesture.translation(in: v).x
        let translationBase: CGFloat = view.frame.width / 3
        let translationAbs = translationX > 0 ? translationX : -translationX
//        let percent = translationAbs > translationBase ? 1.0 : translationAbs / translationBase
        let percent = translationAbs / view.frame.width
        
        print("transaX:\(translationX), base:\(translationBase), percent:\(percent)")
        switch gesture.state{
        case .began:
            navigationDelegate = self.navigationController?.delegate as? NavigationDelegate
            navigationDelegate?.interactive = true
            _ = self.navigationController?.popViewController(animated: true)
        case .changed:
            navigationDelegate?.interactionController.update(percent)
        case .cancelled, .ended:
            if percent > 0.5{
                navigationDelegate?.interactionController.finish()
            }else{
                navigationDelegate?.interactionController.cancel()
            }
            navigationDelegate?.interactive = false
        default: navigationDelegate?.interactive = false
        }
    }
    
    deinit {
        edgePanGesture.removeTarget(self, action: #selector(onEdgePan(gesture:)))
    }
}
