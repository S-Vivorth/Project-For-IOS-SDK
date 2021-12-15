//
//  ViewController.swift
//  testproject1
//
//  Created by San Vivorth on 11/3/21.
//

import UIKit
import testframe2

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    
    let data = "hello"
    
//    @IBAction func buttonclick(_ sender: Any) {
//
//        BottomSheetAnimation().showsheet()
//
//
////        let transitioningDelegate = BottomSheetTransitioningDelegate(
////            contentHeights: [.bottomSheetAutomatic, UIScreen.main.bounds.size.height-200],
////            startTargetIndex: 1  )
////        let frameworkBundle = Bundle(identifier: "bill24.testframe2")
////
////        let viewController = bottomSheetController(nibName: "bottomSheetController", bundle: frameworkBundle)
////        viewController.transitioningDelegate = transitioningDelegate
////        viewController.modalPresentationStyle = .custom
////
////        present(viewController, animated: true)
//////        bottomSheetController().showsheet(views: self.view)
//    }
    
    
    @IBAction func button(_ sender: Any) {
        
        
        BottomSheetAnimation().tappedbtn(views: self,sessionID: "JOTS2Bwd201SwxrbdxCS68nrIPFqRhdCyuj9RbEEmaZX1rOOgEq4lmmr+umMEFmbpRGIwwBOEC3W4D7/+WxP6C4VQwWXvB84HXDf29cU324=", cliendID: "W/GkvceL7nCjOF/v+fu5MA+epIQMXMJedMeXvbvEn7I=",language: "kh"){str in
            self.initPayLater(dict: str)
        } initPaySuccess: { str1 in
            self.initSuccess(dict: str1)
            
        }

//        openApp(appName: "maps")
        
        
//        BottomSheetAnimation().showsheet(views: self)
    }
    
//    @objc func showsheet(){
//        BottomSheetAnimation().tappedbtn(views: self)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 10

//        let btn = checkOutButton()
//        view.addSubview(btn)
//        btn.center = view.center
    
    
//        button.addTarget(self, action: #selector(BottomSheetAnimation().tappedbtn), for: .touchUpInside)
        
    }
    func initSuccess(dict:[String:Any])
    {      
            let bundle = Bundle(for: type(of: self))
            let storyboard = UIStoryboard(name: "paymentSucceed", bundle: bundle)
        let vc:paymentSucceed = storyboard.instantiateViewController(withIdentifier: "paymentSucceed") as! paymentSucceed
        vc.payment_details = dict
            self.present(vc, animated: true, completion: nil)
        
            print("Pay Later screen is opened + string \(dict)")

           }
    func initPayLater( dict:[String:Any]){
            
            let bundle = Bundle(for: type(of: self))
            let storyboard = UIStoryboard(name: "payLater", bundle: bundle)
        let vc:payLater = storyboard.instantiateViewController(withIdentifier: "payLater") as! payLater
        vc.orderDetails = dict
            self.present(vc, animated: true, completion: nil)
            
            print("Pay Later screen is opened + string \(dict)")
    

    }
    
    
    func openApp(appName:String) {
        
        let appScheme = "\(appName)://app"
        let appUrl = URL(string: appScheme)
        
        if UIApplication.shared.canOpenURL(appUrl!) {
            UIApplication.shared.open(appUrl!)
        } else {
            UIApplication.shared.open(URL(string: "calshow://app")!)

        }

    }

}



