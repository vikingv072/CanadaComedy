//
//  NetworkService.swift
//  CanadaComedy
//
//  Created by C02PX1DFFVH5 on 4/10/19.
//  Copyright © 2019 C02PX1DFFVH5. All rights reserved.
//

import Foundation

final class NetworkService {
    private let imagesCache = NSCache<NSString, NSData>()
    static let shared = NetworkService()
    let someUrl = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    func downloader(_ completion: @escaping (([CanadaModel]) -> Void)) {
        guard let useUrl = someUrl else { return }
        URLSession.shared.dataTask(with: useUrl) { (data, _, _) in guard let useData = data else {
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
    func imager(_ factoid: CanadaModel, _ completion: @escaping ((Data?) -> Void)) {
        let URlstr = factoid.imagehref ?? ""
        if let data = self.imagesCache.object(forKey: NSString(string: URlstr)) {
            completion(Data(referencing: data))
            return
        }
        guard let nURL = URL(string: URlstr) else { return }
         // swiftlint:disable:next line_length
        URLSession.shared.dataTask(with: nURL, completionHandler: { (data, URLResponse, _) in guard let safeData = data, URLResponse != nil else {
            completion(nil)
            return
            }
            let httpresponse = URLResponse as? HTTPURLResponse
            print(httpresponse?.statusCode ?? "200")
            if httpresponse?.statusCode == 200 {
                self.imagesCache.setObject(NSData(data: safeData), forKey: NSString(string: URlstr))
                factoid.image = safeData
                completion(safeData)
            } else {
                completion(nil)
            }
        }).resume()
    }
    func imageDload(_ factoid: CanadaModel, _ completion: @escaping (Data?) -> Void) {
        let URLStr = factoid.imagehref ?? ""
        //swiftlint:disable:next control_statement
        if (URLStr == "") {
            completion(nil)
            return
        }
        if let data = self.imagesCache.object(forKey: NSString(string: URLStr)) {
            completion(Data(referencing: data))
        } else {
            self.imager(factoid, completion)
        }
    }
}
