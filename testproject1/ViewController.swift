//
//  ViewController.swift
//  testproject1
//
//  Created by San Vivorth on 11/3/21.
//

import UIKit
import testframe2
import Alamofire
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switchLanguage: UISwitch!
    @IBOutlet weak var orderRefEditText: UITextField!
    var orderRef:String!
    var language:String = "kh"

    
    
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
    

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if orderRefEditText.text != "" {
            orderRefEditText.layer.borderWidth = 0
            orderRefEditText.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        orderRefEditText.resignFirstResponder()
        self.view.endEditing(true)
        return false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if orderRefEditText.text != "" {
            orderRefEditText.layer.borderWidth = 0
            orderRefEditText.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBAction func button(_ sender: Any) {
        if orderRefEditText.text == "" {
            orderRefEditText.layer.borderWidth = 2
            orderRefEditText.layer.borderColor = UIColor.red.cgColor
            orderRefEditText.becomeFirstResponder()
            return
        }
        
        
        orderRef = orderRefEditText.text
        
        let parameters =
            [
                    "customer": [
                        "customer_ref": "C00001",
                        "customer_email": "example@gmail.com",
                        "customer_phone": "010801252",
                        "customer_name": "test customer"
                    ],
                    "billing_address": [
                        "province": "Phnom Penh",
                        "country": "Cambodia",
                        "address_line_2": "string",
                        "postal_code": "12000",
                        "address_line_1": "No.01, St.01, Toul Kork"
                    ],
                    "description": "Extra note",
                    "language": "km",
                    "order_items": [
                        [
                            "item_name": "Men T-Shirt",
                            "quantity": 1,
                            "price": 1,
                            "amount": 1,
                            "item_ref": "P1001",
                            "discount_amount": 0
                        ]
                    ],
                    "payment_success_url":  "/payment/success",
                    "currency": "USD",
                    "amount": 1,
                    "pay_later_url":  "/payment/paylater",
                    "shipping_address": [
                        "province": "Phnom Penh",
                        "country": "Cambodia",
                        "address_line_2": "string",
                        "postal_code": "12000",
                        "address_line_1": "No.01, St.01, Toul Kork"
                    ],
                    "order_ref":orderRef,
                    "payment_fail_url": "payment/fail",
                    "payment_cancel_url": "payment/cancel",
                    "continue_shopping_url":  "payment/cancel"
            ] as [String : Any]
        if switchLanguage.isOn == true {
            
            language = "kh"
        }
        else{
            language = "en"
        }
        
        
        
        let headers: HTTPHeaders = [
            "token" : "f91d077940cf44ebbb1b6abdebce0f0a",
            "Accept": "application/json"
        ]
        var result:InitOrder!
                
                AF.request("https://checkoutapi-staging.bill24.net/order/init", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response {
                        (responseData) in
                    var responded = responseData.data!
                        print(String(data: responded, encoding: .utf8))
                    let dict = self.convertToDictionary(text: String(data: responded, encoding: .utf8)!)
                    guard let session_id = ((dict!["data"] as! [String:Any])["session_id"] as? String) else {
                        return
                    }
                    BottomSheetAnimation().tappedbtn(views: self,sessionID: session_id, cliendID: "W/GkvceL7nCjOF/v+fu5MA+epIQMXMJedMeXvbvEn7I=",language: self.language){str in
                        self.initPayLater(dict: str)
                    } initPaySuccess: { str1 in
                        self.initSuccess(dict: str1)

                    }
                    
                }

//        openApp(appName: "maps")
        
        
//        BottomSheetAnimation().showsheet(views: self)
    }
    
//    @objc func showsheet(){
//        BottomSheetAnimation().tappedbtn(views: self)
//
//    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 10
        orderRefEditText.delegate = self
        orderRefEditText.becomeFirstResponder()
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
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
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
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



