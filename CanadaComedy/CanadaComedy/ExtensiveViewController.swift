//
//  ExtensiveViewController.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/18/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

class ExtensiveViewController: UIViewController {

    @IBAction func backButton(_ sender: Any) {
        
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
    var datum: Data?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = datum {
            self.imageViews.image = UIImage(data: data)
            self.view.layoutIfNeeded()
        } else {
            self.imageViews.image = UIImage(named: "Qmark??")
        }
    }
}
