//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation

public struct Coin: Decodable {
    
    public let assetID, name: String
    let typeIsCrypto: Int
    let dataQuoteStart, dataQuoteEnd, dataOrderbookStart, dataOrderbookEnd: String
    let dataTradeStart, dataTradeEnd: String
    let dataSymbolsCount: Int
    let volumeOneHrsUsd, volumeOneDayUsd: Double
    let volumeOneMthUsd: Double
    public let priceUsd: Double?
    public let idIcon: String?
    let dataStart, dataEnd: String?
    
    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case name
        case typeIsCrypto = "type_is_crypto"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volumeOneHrsUsd = "volume_1hrs_usd"
        case volumeOneDayUsd = "volume_1day_usd"
        case volumeOneMthUsd = "volume_1mth_usd"
        case priceUsd = "price_usd"
        case idIcon = "id_icon"
        case dataStart = "data_start"
        case dataEnd = "data_end"
    }
}
