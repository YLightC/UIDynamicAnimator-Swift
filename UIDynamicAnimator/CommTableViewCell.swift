//
//  CommTableViewCell.swift
//  UIDynamicAnimator
//
//  Created by yaosixu on 2016/10/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import Foundation

class CommTableViewCell : NSObject {
    
    var title : String = ""
    var image : String = ""
    var action : ((Void) -> Void)?
    
    override init() {
        super.init()
    }
    
    init(_ cellTitle: String, imgage cellImage: String, cellAction action: ((Void) -> Void)?) {
        self.title = cellTitle
        self.image = cellImage
        self.action = action
    }
    
}
