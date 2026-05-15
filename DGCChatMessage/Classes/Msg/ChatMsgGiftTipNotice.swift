//
//  DGCChatMsgGiftTipNotice.swift
//  MGNetWork
//
//  Created by Pi0007 on 2026/4/2.
//

import Foundation

public class DGCChatMsgGiftTipNotice: DGCChatMsg , Codable {
    
    public internal(set) var giftName : String = ""
     
    public internal(set) var giftIcon : String = ""
    
    public internal(set) var giftPrice : Int64 = 0
    
    public internal(set) var giftNum : Int32 = 0
    
    enum CodingKeys: String, CodingKey {
        case giftName
        case giftIcon
        case giftPrice
        case giftNum
    }

    public func encode(to encoder: Encoder) throws {
        var dgc_container = encoder.container(keyedBy: CodingKeys.self)
        try dgc_container.encode(giftName, forKey: .giftName)
        try dgc_container.encode(giftIcon, forKey: .giftIcon)
        try dgc_container.encode(giftPrice, forKey: .giftPrice)
        try dgc_container.encode(giftNum, forKey: .giftNum)
    }

    required public init(from decoder: Decoder) throws {
        super.init()
        let dgc_container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = .GiftTipOutRoom
        giftName = (try? dgc_container.decode(String.self, forKey: .giftName)) ?? ""
        giftIcon = (try? dgc_container.decode(String.self, forKey: .giftIcon)) ?? ""
        giftPrice = (try? dgc_container.decode(Int64.self, forKey: .giftPrice)) ?? 0
        giftNum = (try? dgc_container.decode(Int32.self, forKey: .giftNum)) ?? 0
    }
    
}
