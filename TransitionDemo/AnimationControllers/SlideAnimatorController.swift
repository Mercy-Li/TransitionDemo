//
//  SlideAnimatorController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

enum TabOperationDirection {
    case left, right
}

enum ModalOperation {
    case present
    case dismiss
}

enum TransitionType {
    case navigation(UINavigationController.Operation)
    case tabbar(TabOperationDirection)
    case modal(ModalOperation)
}

class SlideAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    private var transitionType: TransitionType
    
    init(type: TransitionType) {
        transitionType = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else{
            return
        }
        
        let fromView = fromVC.view
        let toView = toVC.view
        
        var translation = containerView.frame.width
        var toViewTransform = CGAffineTransform.identity
        var fromViewTransform = CGAffineTransform.identity
        
        switch transitionType{
        case .navigation(let operation):
            translation = operation == .push ? translation : -translation
            toViewTransform = CGAffineTransform(translationX: translation, y: 0)
            fromViewTransform = CGAffineTransform(translationX: -translation, y: 0)
        case .tabbar(let direction):
            translation = direction == .left ? translation : -translation
            fromViewTransform = CGAffineTransform(translationX: translation, y: 0)
            toViewTransform = CGAffineTransform(translationX: -translation, y: 0)
        case .modal(let operation):
            translation =  containerView.frame.height
            toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
            fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
        }

        switch transitionType{
        case .modal(let operation):
            switch operation{
            case .present: containerView.addSubview(toView!)
            case .dismiss: break
            }
        default: containerView.addSubview(toView!)
        }
        
        toView?.transform = toViewTransform
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView?.transform = fromViewTransform
            toView?.transform = CGAffineTransform.identity
            }, completion: { finished in
                fromView?.transform = CGAffineTransform.identity
                toView?.transform = CGAffineTransform.identity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
