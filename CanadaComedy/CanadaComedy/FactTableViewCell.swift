//
//  FactTableViewCell.swift
//  
//
//  Created by C02PX1DFFVH5 on 4/13/19.
//

import UIKit

class FactTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var imageViewer: UIImageView!
    var datImg: Data? = Data()
    func imageConfigurer(with factoid: CanadaModel) {
        NetworkService.shared.imageDload(factoid) { [weak self] (imagedata) in
            DispatchQueue.main.async {
                self?.imageViewer.contentMode = .scaleAspectFit
                self?.datImg = imagedata
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
        } else {
            descLabel.text = "N/A"
        }
    }
}
