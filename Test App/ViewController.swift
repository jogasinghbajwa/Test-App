//
//  ViewController.swift
//  Test App
//
//  Created by Joga Singh on 02/05/18.
//  Copyright © 2018 Arethos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var FilterView: UIView!
    
    @IBOutlet weak var curveViewHeight: NSLayoutConstraint!
    
    let nib_Name:String = "TestView"
    let animationDurationShort = 0.2
    let animationDurationMedium = 0.5
    let animationDurationLong = 1.0
    var testView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  addCurve(myview: myView)
        curveViewHeight.constant = 0;
        myView.alpha = 0;
        testView = getViewFromNibName(nibName: nib_Name)
        testView.frame = FilterView.bounds
        FilterView.addSubview(testView)
        FilterView.alpha = 0;
        
        let view:TestView = TestView .getViewFromNibName(nibName: nib_Name)
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addCurve(myview: myView)
        self.myView.animate(alpha: 1, duration: animationDurationShort)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeHeight(_ sender: UIButton) {
        
        let constant: CGFloat = curveViewHeight.constant == 0 ? 200 : 0
        let filterViewAlpha: CGFloat = curveViewHeight.constant == 0 ? 1.0 : 0.0
//        if(curveViewHeight.constant == 0)
//        {
//            curveViewHeight.constant = 200;
//            FilterView.animate(alpha: 1, duration: animationDurationMedium)
//        }else{
//            curveViewHeight.constant = 0;
//            FilterView.animate(alpha: 0, duration: animationDurationMedium)
//        }

        curveViewHeight.constant = constant;
        UIView.animate(withDuration: animationDurationLong) {
            self.view.layoutIfNeeded()
            self.FilterView.alpha = filterViewAlpha;
        }
    }
    override func viewWillLayoutSubviews() {
        createGradientLayer()
        super.viewWillLayoutSubviews()
    }
}

extension UIViewController
{
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(red: 72/255.0, green: 166/255.0, blue: 207/255.0, alpha: 1).cgColor, UIColor.init(red: 209/255.0, green: 77/255.0, blue: 180/255.0, alpha: 1).cgColor]
        gradientLayer.masksToBounds = true
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addCurve(myview: UIView) -> Void {
        let maskLayer = CAShapeLayer(layer: myview.layer)
        let bezierPath = UIBezierPath()
        // Initial Points
        bezierPath.move(to: CGPoint(x:0, y:0))
        // Cover X-axis not to be cut by mask layer
        bezierPath.addLine(to: CGPoint(x:myview.bounds.size.width, y:0))
        // Cover height & width of view not to be cut by mask layer
        bezierPath.addLine(to: CGPoint(x:myview.bounds.size.width, y:myview.bounds.size.height/2))
        // Add Curve on Bottom
        bezierPath.addQuadCurve(to: CGPoint(x:0, y:myview.bounds.size.height/2), controlPoint: CGPoint(x:myview.bounds.size.width/2, y:myview.bounds.size.height-myview.bounds.size.height*0))
        bezierPath.close()
        // Create Mask layer to cut view
        maskLayer.path = bezierPath.cgPath
        maskLayer.frame = myview.bounds
        maskLayer.masksToBounds = true
        myview.layer.mask = maskLayer
    }
    

    func getViewFromNibName(nibName: String) -> UIView {
        return UINib.init(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}

extension UIView
{
    func animate(alpha: CGFloat, duration: Double) -> Void {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}


