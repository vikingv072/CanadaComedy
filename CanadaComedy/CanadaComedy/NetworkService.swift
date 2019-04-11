//
//  NetworkService.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/10/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    let someUrl = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    func nullTonil(value: AnyObject) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    func downloader(_ completion: @escaping (([CanadaModel]) -> Void)) {
        guard let useUrl = someUrl else { return }
        URLSession.shared.dataTask(with: useUrl){ (data, _ , _ ) in guard let useData = data else {
                print("Going Wonky")
                return}
            print("Downloaded")
            let decoder = JSONDecoder()
            do {
                let val = try? decoder.decode([CanadaModel].self, from: useData)
                completion(val ?? [])
            } catch { print(error) }
        }.resume()
    }
}
