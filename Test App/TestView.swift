//
//  TestView.swift
//  Test App
//
//  Created by Joga Singh on 03/05/18.
//  Copyright © 2018 Arethos. All rights reserved.
//

import UIKit

 class TestView: UIView {

    static func getViewFromNibName(nibName: String) -> TestView {
        let view = UINib.init(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! TestView
        
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
