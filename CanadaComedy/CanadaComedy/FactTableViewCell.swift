//
//  FactTableViewCell.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/13/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

class FactTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageViewer: UIImageView!
    func imageConfigurer(with factoid: CanadaModel) {
        NetworkService.shared.imageDload(factoid) { [weak self] (imagedata) in
            DispatchQueue.main.async {
                self?.imageViewer.contentMode = .scaleAspectFit
                if imagedata != nil {
                    self?.imageViewer.image = UIImage(data: imagedata!)
                } else {
                    self?.imageViewer.image = UIImage(named: "Qmark??")
                }
            }
        }
    }
    func textConfigurer(with factoid: CanadaModel) {
        if let name = factoid.title {
            titleLabel.text = name
        } else {
            titleLabel.text = "N/A"
        }
        if let desc = factoid.description {
            descLabel.text = desc
            descLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        } else {
            descLabel.text = "N/A"
        }
    }
}
