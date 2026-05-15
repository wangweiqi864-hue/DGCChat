//
//  DGCChatMsgGift.swift
//  Pods
//
//  Created by Pi0007 on 2025/6/27.
//

import Foundation

public class DGCChatMsgGift: DGCChatMsg, Codable {
    
    private override init() {
        super.init()
        type = .Gift
    }
    
    public internal(set) var gId : Int64 = 0 // 礼物ID
    public internal(set) var giftNumer : Int64 = 0
    public internal(set) var targetId : String = ""
    public internal(set) var giftGold: Int64 = 0 // 礼物价格
    public internal(set) var action : Int32 = 0 // 送礼后执行的动作 0：普通im送礼
    public internal(set) var uuid : String = "" // 发送礼物时自动生成的礼物UUID 用于透传

    public func encode(to encoder: Encoder) throws {
        var dgc_container = encoder.container(keyedBy: CodingKeys.self)
        try dgc_container.encode(self.gId, forKey: .giftId)
        try dgc_container.encode(self.giftNumer, forKey: .giftNum)
        try dgc_container.encode(self.targetId, forKey: .receiverId)
        try dgc_container.encode(self.uuid, forKey: .msg)
        try dgc_container.encode(self.action, forKey: .action)
    }
    
    enum CodingKeys: CodingKey {
        case giftId
        case giftNum
        case receiverId
        case msg
        case action
    }
    
    required public init(from decoder: Decoder) throws {
        super.init()
        type = .Gift
        
        let dgc_container = try decoder.container(keyedBy: CodingKeys.self)
        self.gId = (try? dgc_container.decode(Int64.self, forKey: .giftId)) ?? 0
        self.giftNumer = (try? dgc_container.decode(Int64.self, forKey: .giftNum)) ?? 0
        self.targetId = (try? dgc_container.decode(String.self, forKey: .receiverId)) ?? ""
        self.uuid = (try? dgc_container.decode(String.self, forKey: .msg)) ?? ""
        self.action = (try? dgc_container.decode(Int32.self, forKey: .action)) ?? 0
    }
    
}
