//
//  CViewModel.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/10/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation

private let INCREMENTval = 4

class CViewModel {
    var imgData: Data? = Data()
    var canadaFacts = [CanadaModel]() {
        didSet {
            self.updateUI?()
        }
    }
    private var updateUI: (() -> Void)?
    var counter: Int = 0
    private var isLoading = false
    init(_ callback: (() -> Void)?) {
        self.updateUI = callback
    }
    func getFacts() {
        NetworkService.shared.downloader({ [weak self] canadaFacts in
            self?.canadaFacts = canadaFacts
            self?.loadMoreItems()
        })
    }
    func titleRetrieve(_ index: Int) -> String {
        if let title = self.canadaFacts[index].title {
            return title
        } else {
            return "N/A"
        }
    }
    func descRetrieve(_ index: Int) -> String {
        if let desc = self.canadaFacts[index].description {
            return desc
        } else {
            return "N/A"
        }
    }
    func imageRetrieve(_ index: Int, _ completion: @escaping (Data?) -> Void) {
        let reqFact = self.canadaFacts[index]
        NetworkService.shared.imageDload(reqFact) {[weak self] (imagedata) in DispatchQueue.main.async {
            self?.imgData = imagedata
            completion(self?.imgData)
            }
        }
    }
    func loadMoreItems() {
        if isLoading == true { return }
        isLoading = true
        let newAmount = min(counter + INCREMENTval, canadaFacts.count) // whatever increment value is
        // load the next 4 images
        let group = DispatchGroup()
        group.notify(queue: .main) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.counter = newAmount
            weakSelf.updateUI?()
            weakSelf.isLoading = false
        }
        for index in counter..<newAmount {
            group.enter()
            let reqFact = self.canadaFacts[index]
            NetworkService.shared.imageDload(reqFact) { (_) in
                group.leave()
            }
        }
    }
}
