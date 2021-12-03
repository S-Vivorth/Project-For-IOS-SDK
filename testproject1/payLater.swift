//
//  payLater.swift
//  testproject1
//
//  Created by San Vivorth on 11/26/21.
//

import Foundation
import UIKit

class payLater: UIViewController {
    @IBOutlet weak var continuebtn: UIButton!
    @IBAction func continueShoppingBtn(_ sender: Any) {
        let bundle = Bundle(for: type(of: self)) //important => if not inclue this => it cannot load the xib file
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        continuebtn.layer.cornerRadius = 10

    }
}
