//
//  SettingViewController.swift
//  Test App
//
//  Created by Joga Singh on 16/05/18.
//  Copyright © 2018 Arethos. All rights reserved.
//

import UIKit



class SettingViewController: UIViewController {

    // Push Notification Outlets
    @IBOutlet weak var showPushNotificationButton: UISwitch!
    @IBOutlet weak var FilterViewHeightConstant: NSLayoutConstraint!
   var filterViewHeight: CGFloat = 0
    
    // User Detail Outlets
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var userDetailViewConstant: NSLayoutConstraint!
    
    var userDetailViewHeight: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterViewHeight = FilterViewHeightConstant.constant
        userDetailViewHeight = userDetailViewConstant.constant
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func pushNotificationButtonTapped(_ sender: UISwitch) {
        FilterViewHeightConstant.constant = 0;
        if(sender.isOn)
        {
            FilterViewHeightConstant.constant = filterViewHeight;
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func userDetailButtonTapped(_ sender: UISwitch) {
        userDetailViewConstant.constant = 0;
        if(sender.isOn)
        {
            userDetailViewConstant.constant = userDetailViewHeight;
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
