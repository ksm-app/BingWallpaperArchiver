//
//  File.swift
//  
//
//  Created by Zijie Liu on 8/11/22.
//
import Foundation

// MARK: - BingWPResponse
struct BingWPResponse: Codable {
    let images: [BingWPImage]
}

// MARK: - Image
struct BingWPImage: Codable, Comparable {
    static func < (lhs: BingWPImage, rhs: BingWPImage) -> Bool {
        return Int(lhs.startdate) ?? 0 < Int(rhs.startdate) ?? 0
    }
    let startdate, fullstartdate, enddate, url: String
    let urlbase, copyright: String
    let copyrightlink: String
    let title, quiz: String
    let wp: Bool
    let hsh: String
    let drk, top, bot: Int
}
