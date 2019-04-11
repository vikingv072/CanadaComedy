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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CViewModel ({[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        self.setTable()
        self.viewModel.getFacts()
    }
    func setTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.counter
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.viewModel.titleRetrieve(indexPath.row)
        return cell
    }
}
