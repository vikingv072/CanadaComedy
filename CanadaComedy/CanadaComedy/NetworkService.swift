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
        URLSession.shared.dataTask(with: useUrl){ (data, response , _ ) in guard let useData = data else {
                print("Going Wonky")
                return}
            print("Downloaded")
            guard let isoLatStr = String(data: useData, encoding: .isoLatin1) else {// ISO-8859-1
                print("incorrect format")
                return
            }
            print(isoLatStr)
            guard let utf8Dat = isoLatStr.data(using: .utf8) else {
                print("Could not make utf8")
                return
            }
            let decoder = JSONDecoder()
            do {
                let val = try decoder.decode(BaseModel.self, from: utf8Dat)
                completion(val.rows)
                print(val.rows.count)
            } catch {
                print(error)
            }
        }.resume()
    }
}
