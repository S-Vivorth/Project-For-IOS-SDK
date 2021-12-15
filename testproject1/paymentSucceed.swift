//
//  paymentSucceed.swift
//  testproject1
//
//  Created by San Vivorth on 11/29/21.
//

import Foundation
import UIKit
import Alamofire
class paymentSucceed : UIViewController {
    var payment_details:[String:Any]!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var contineBtn: UIButton!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionID: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var orderRef: UILabel!
    @IBAction func continueShoppingBtn(_ sender: Any) {
        let bundle = Bundle(for: type(of: self)) //important => if not inclue this => it cannot load the xib file
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [
            "token" : "f91d077940cf44ebbb1b6abdebce0f0a",
            "Accept": "application/json"
        ]
        print(payment_details!)
        print(type(of: payment_details!))
        let tran_id = (payment_details!["tran_data"] as! [String:Any])["trans_id"] as! String
        print(tran_id)
        let parameters = [
            "tran_id": "\(tran_id)"
        ]
        AF.request("https://checkoutapi-staging.bill24.net/transaction/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).response { responseData in
            print("codeee :\(responseData.response?.statusCode)")
            print(String(data: responseData.data!, encoding: .utf8))
            let dict = self.convertToDictionary(text: String(data: responseData.data!, encoding: .utf8)!)!
            self.totalPrice.text = String((dict["data"] as! [String:Any])["total_amount"] as! Double) + " USD"
            let date = ((dict["data"] as! [String:Any])["tran_date"] as! String)
            let date_split = date.split(separator: ".")
            self.transactionDate.text = "\(date_split[0])"
            self.transactionID.text = (dict["data"] as! [String:Any])["tran_id"] as! String
            self.fee.text = String((dict["data"] as! [String:Any])["fee_amount"] as! Double) + " USD"
            self.paymentMethod.text = (self.payment_details["tran_data"] as! [String:Any])["bank_name_en"] as! String
            self.subTotal.text = String((dict["data"] as! [String:Any])["tran_amount"] as! Double) + " USD"
            self.orderRef.text = "Order #\((self.payment_details["tran_data"] as! [String:Any])["order_ref"] as! String)"
        }
        contineBtn.layer.cornerRadius = 10
        
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
}

