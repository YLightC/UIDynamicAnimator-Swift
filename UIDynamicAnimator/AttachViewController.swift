//
//  AttachViewController.swift
//  UIDynamicAnimator
//
//  Created by yaosixu on 2016/10/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/** 吸附行为 */

class AttachViewController: UIViewController {
    
    var attachButton = UIButton()
    var animator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "吸附行为"
        view.backgroundColor = UIColor.darkGray
        attachButton = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        attachButton.backgroundColor = UIColor.blue
        view.addSubview(attachButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAttach()
    }
    
    func showAttach() {
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator.delegate = self
        
        let attachBehavior = UIAttachmentBehavior(item: attachButton, attachedToAnchor: attachButton.center)
        attachBehavior.length = 20
        //设置吸附还原时的阻力系数大小
        attachBehavior.damping = 0.1
        //设置震荡频率
        attachBehavior.frequency = 2.3
        animator.addBehavior(attachBehavior)
        
        //加一个推力 推力的类型有两种一种是瞬间的推力，一种是连续的 分别对应的是 instantaneous 和  continuous
        let pushBehavior = UIPushBehavior(items: [attachButton], mode: .instantaneous)
        //设置推力可用
        pushBehavior.active = true
        //设置力的方向
        pushBehavior.pushDirection = CGVector(dx: 1, dy: 0)
        //设置力的大小
        pushBehavior.magnitude = 100
        animator.addBehavior(pushBehavior)
    }
}

extension AttachViewController : UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        print("\(#function)")
    }
    
}

