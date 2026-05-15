//
//  DGCChatMsgRelationshipUnbind.swift
//  DGCChatMessage
//
//  Created by Pi0007 on 2026/1/19.
//

import Foundation

public class DGCChatMsgRelationshipUnbind: DGCChatMsg , Codable {
    
    public internal(set) var relationshipType : RelationshipType = .UN // 关系类型
    
    public internal(set) var opt : Int32 = 0 // 1-发起解绑 2-取消解绑 3-成功解绑
    
    public internal(set) var sender : Int64 = 0 //关系邀请者
    
    public internal(set) var receiver : Int64 = 0 //关系被邀请者
    
   
    public enum RelationshipType : Int32, Codable{
        case UN = 0
        case CP = 1
        case Friend = 2
    }

    enum CodingKeys: String, CodingKey {
        case relationshipType
        case opt
        case sender
        case receiver
    }

    public func encode(to encoder: Encoder) throws {
        var dgc_container = encoder.container(keyedBy: CodingKeys.self)
        try dgc_container.encode(relationshipType, forKey: .relationshipType)
        try dgc_container.encode(opt, forKey: .opt)
        try dgc_container.encode(sender, forKey: .sender)
        try dgc_container.encode(receiver, forKey: .receiver)
    }

    required public init(from decoder: Decoder) throws {
        super.init()
        let dgc_container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = .RelationshipUnbind
        relationshipType = (try? dgc_container.decode(RelationshipType.self, forKey: .relationshipType)) ?? .UN
        opt = (try? dgc_container.decode(Int32.self, forKey: .opt)) ?? 0
        sender = (try? dgc_container.decode(Int64.self, forKey: .sender)) ?? 0
        receiver = (try? dgc_container.decode(Int64.self, forKey: .receiver)) ?? 0
    }
    
}
