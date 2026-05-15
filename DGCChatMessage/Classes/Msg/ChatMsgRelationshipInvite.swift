//
//  DGCChatMsgRelationshipInvite.swift
//  Pods
//
//  Created by bond on 2026/1/15.
//

public class DGCChatMsgRelationshipInvite: DGCChatMsg , Codable {
    
//    public internal(set) var giftId : Int64 = 0 // 礼物Id
    public internal(set) var inviteId : Int64 = 0 // 邀请Id
    public internal(set) var relationshipType : RelationshipType = .UN // 关系类型
    
//    public internal(set) var rsStatus : RelationshipStatus = .un // 绑定状态
    
    public internal(set) var icon : String = String() // 礼物icon
    
    private var dgc_cloudCustomData : DGCChatMsgCloudCustomData?
    public override var cloudCustomData: DGCChatMsgCloudCustomData?{
        get{dgc_cloudCustomData}
        set{
            dgc_updateRelationshipStatus(newValue)
            dgc_cloudCustomData = newValue
        }
    }
    
    private var dgc_timeTimeInterval : TimeInterval = 0
    public override var time: TimeInterval{
        get{dgc_timeTimeInterval}
        set{
            dgc_timeTimeInterval = newValue
            dgc_updateRelationshipStatus(self.cloudCustomData)
        }
    }
    
    public enum RelationshipType : Int32, Codable{
        case UN = 0
        case CP = 1
        case Friend = 2
    }
    
    private func dgc_updateRelationshipStatus(_ newValue : DGCChatMsgCloudCustomData?) {
        if self.time <= 0  {
            return
        }
        let dgc_relationshipStatus = newValue?.relationshipStatus ?? .un
        
        if dgc_relationshipStatus == .un {
            // 判断是否过期 24小时
            let dgc_time = Date().timeIntervalSince1970 - self.time
            let dgc_maxTime = 24.0 * 60 * 60
            if dgc_time > dgc_maxTime {
                newValue?.relationshipStatus = .expiration
                modifyMessage() // 修改当前的消息 为过期状态
            }
        }
        
    }
    
    
    public init(icon : String,inviteId : Int64,relationshipType : RelationshipType) {
        super.init()
        self.icon = icon
        self.inviteId = inviteId
        self.type = .RelationshipInvite
//        self.rsStatus = status
        self.relationshipType = relationshipType
        self.cloudCustomData = DGCChatMsgCloudCustomData() // 初始化这个数据
    }
    
    enum CodingKeys: String, CodingKey {
        case giftId
        case relationshipType
        case inviteId
        case relationshipStatus
        case icon
    }

    public func encode(to encoder: Encoder) throws {
        var dgc_container = encoder.container(keyedBy: CodingKeys.self)
        try dgc_container.encode(icon, forKey: .icon)
        try dgc_container.encode(relationshipType, forKey: .relationshipType)
        try dgc_container.encode(inviteId, forKey: .inviteId)
//        try dgc_container.encode(rsStatus, forKey: .relationshipStatus)
    }

    required public init(from decoder: Decoder) throws {
        super.init()
        let dgc_container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = .RelationshipInvite
        icon = (try? dgc_container.decode(String.self, forKey: .icon)) ?? ""
        relationshipType = (try? dgc_container.decode(RelationshipType.self, forKey: .relationshipType)) ?? .UN
        inviteId = (try? dgc_container.decode(Int64.self, forKey: .inviteId)) ?? 0
        
//        rsStatus = (try? dgc_container.decode(RelationshipStatus.self, forKey: .relationshipStatus)) ?? .un
    }
    
}
