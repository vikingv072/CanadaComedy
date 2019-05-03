//
//  MainViewController.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/10/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: CViewModel!
    var currCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CViewModel ({[weak self] in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                var indexPaths = [IndexPath]()
                let newCounter = weakSelf.viewModel.counter
                for index in weakSelf.currCount..<newCounter {
                    indexPaths.append(IndexPath(row: index, section: 0))
                }
                weakSelf.tableView.insertRows(at: indexPaths, with: .automatic)
                weakSelf.currCount = newCounter
                //weakSelf.tableView.reloadData()
            }
        })
        self.setTable()
        self.viewModel.getFacts()
    }
    func setTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let factsNib = UINib(nibName: "FactTableViewCell", bundle: nil)
        self.tableView.register(factsNib, forCellReuseIdentifier: "FactTableViewCell")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.counter
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next line_length
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactTableViewCell", for: indexPath) as? FactTableViewCell
        cell?.imageConfigurer(with: viewModel.canadaFacts[indexPath.row])
        cell?.titleConfigurer(with: viewModel.canadaFacts[indexPath.row])
        cell?.descConfigurer(with: viewModel.canadaFacts[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.counter - 1 {
            viewModel.loadMoreItems()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // swiftlint:disable:next line_length 
        guard let vc1 = storyboard?.instantiateViewController(withIdentifier: "ExtensiveViewController") as? ExtensiveViewController else {
            return
        }
        vc1.loadViewIfNeeded()
        vc1.titleLabel.text = self.viewModel.titleRetrieve(indexPath.row)
        vc1.descLabel.text = self.viewModel.descRetrieve(indexPath.row)
        self.viewModel.imageRetrieve(indexPath.row) { [weak self] (data) in
            vc1.datum = data
            self?.show(vc1, sender: nil)
        }
    }
}

extension NSLayoutConstraint {
    override open var description: String {
        let ide = identifier ?? ""
        return "id: \(ide), constant: \(constant)"
    }
}
