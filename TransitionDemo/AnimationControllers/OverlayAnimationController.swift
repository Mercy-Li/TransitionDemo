//
//  OverlayAnimationController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class OverlayAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let fromView = fromVC.view!
        let toView = toVC.view!
        let duration = transitionDuration(using: transitionContext)
        
        if toVC.isBeingPresented {
            containerView.addSubview(toView)
            
            let toViewWidth = containerView.frame.width * 2 / 3, toViewHeight = containerView.frame.height * 2 / 3
            toView.center = containerView.center
            toView.bounds = CGRect(x: 0, y: 0, width: 1, height: toViewHeight)
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                toView.bounds = CGRect(x: 0, y: 0, width: toViewWidth, height: toViewHeight)
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
        if fromVC.isBeingDismissed {
            let fromViewHeight = fromView.frame.height
            UIView.animate(withDuration: duration, animations: {
                fromView.bounds = CGRect(x: 0, y: 0, width: 1, height: fromViewHeight)
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    

}
