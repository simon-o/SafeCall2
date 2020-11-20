//
//  HalfViewTransition.swift
//  SafeCall
//
//  Created by Antoine Simon on 15/11/2020.
//

import Foundation
import UIKit

class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }

            return CGRect(x: 0,
                          y: theView.bounds.height/2,
                          width: theView.bounds.width,
                          height: theView.bounds.height/2)
        }
    }
    
    override func presentationTransitionWillBegin() {
            let bdView = UIView(frame: containerView!.bounds)
            bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            containerView?.addSubview(bdView)
            bdView.addSubview(presentedView!)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            bdView.addGestureRecognizer(tapGesture)
        }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let vcb = presentedViewController as! EmergencyViewController
            vcb.dismiss(animated: true, completion: nil)
        }
}
