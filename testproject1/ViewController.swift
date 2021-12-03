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
        
        
        BottomSheetAnimation().tappedbtn(views: self,sessionID: "JOTS2Bwd201SwxrbdxCS6xP9iQe+yAbrgrAtpEc7Rmo8tczix4RKTfLT92VH8xoxvOQdGhXmyjwHna3qZJwxQEyu8sNYUTJqWceTylBOcLY=", cliendID: "W/GkvceL7nCjOF/v+fu5MA+epIQMXMJedMeXvbvEn7I="){str in
            self.initPayLater(a: str)
        } initPaySuccess: { str1 in
            self.initSuccess(b: str1)
            
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
    func initSuccess(b:String?)
    {      
            let bundle = Bundle(for: type(of: self))
            let storyboard = UIStoryboard(name: "paymentSucceed", bundle: bundle)
            let vc = storyboard.instantiateViewController(withIdentifier: "paymentSucceed")
            self.present(vc, animated: true, completion: nil)
        
            print("Pay Later screen is opened + string \(b)")

           }
    func initPayLater( a:String?){
            
            let bundle = Bundle(for: type(of: self))
            let storyboard = UIStoryboard(name: "payLater", bundle: bundle)
            let vc = storyboard.instantiateViewController(withIdentifier: "payLater")
            self.present(vc, animated: true, completion: nil)
        
            print("Pay Later screen is opened + string \(a)")
    

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



