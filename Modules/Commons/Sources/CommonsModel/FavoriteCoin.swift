//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 11/03/22.
//

import Foundation

public struct FavoriteCoin : Codable {
    public var assetID: String = ""
    
    public init() {}
    
    public init(_ assetID: String) {
        self.assetID = assetID
    }
}
