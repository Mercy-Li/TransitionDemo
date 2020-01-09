//
//  ModalTransitionDelegate.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class ModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OverlayAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OverlayAnimationController()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return OverlayPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
