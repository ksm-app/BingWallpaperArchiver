//
//  File.swift
//  
//
//  Created by Zijie Liu on 8/11/22.
//

import Foundation

struct BingWallpaperDownloader {
    
    private let sourceURI = "https://www.bing.com" + "/HPImageArchive.aspx"
    
    private func getBingWallpaperRequest(index: Int, count: Int, market: Market) -> URLRequest {
        let sourceURI = sourceURI
        let index = min(max(0, index), 8)
        let count = min(max(0, count), 8)
        let urlString = sourceURI.appending("?format=js&idx=\(index)&n=\(count)&mkt=\(market.toString)")
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        print(url)
        return request
    }

    private func getBingWallpaperResponse(with request: URLRequest, handler: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            
            if let data = data {
                handler(data)
            } else {
                print(error?.localizedDescription ?? "data is nil")
            }
        }
        task.resume()
    }
    
    func fetchAllCountriesJson() {
        let group = DispatchGroup()
        
        for market in Market.allCases {
            
            group.enter()
            let request = getBingWallpaperRequest(index: 0, count: 1, market: market)
            
            getBingWallpaperResponse(with: request) { data in
                handleData(data, market: market)
                group.leave()
            }
        }
        
        group.wait()
    }
    
    private func handleData(_ data: Data, market: Market) {
        do {
            let response = try JSONDecoder().decode(BingWPResponse.self, from: data)
            let images = response.images
            let pathString = FileManager.default.currentDirectoryPath
            let filePathString = "file://" + pathString + "/json/" + market.toString + ".json"
            let fileString = pathString + "/json/" + market.toString + ".json"
            
            if FileManager.default.fileExists(atPath: fileString) {
                let url = URL(string: filePathString)!
                let data = try Data(contentsOf: url)
                let oldResponse = try JSONDecoder().decode(BingWPResponse.self, from: data)
                let arr = Array((oldResponse.images + images).sorted().reversed())
                let newResponse = BingWPResponse(images: arr)
                let encodedData = try JSONEncoder().encode(newResponse)
                let json = String(data: encodedData, encoding: .utf8)
                try json?.write(to: URL(string: filePathString)!, atomically: true, encoding: .utf8)
                
            } else {
                let json = String(data: data, encoding: .utf8)
                try json?.write(to: URL(string: filePathString)!, atomically: true, encoding: .utf8)
            }
            
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
