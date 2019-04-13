//
//  CViewModel.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/10/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation

class CViewModel {
    var canadaFacts = [CanadaModel]() {
        didSet {
            self.updateUI?()
        }
    }
    private var updateUI: (() -> Void)?
    var counter: Int {
        return canadaFacts.count
    }
    init(_ callback: (() -> Void)?) {
        self.updateUI = callback
    }
    func getFacts() {
        NetworkService.shared.downloader({ [weak self] canadaFacts in
            self?.canadaFacts = canadaFacts
        })
    }
}
