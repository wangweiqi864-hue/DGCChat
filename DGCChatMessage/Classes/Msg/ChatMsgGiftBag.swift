//
//  DGCChatMsgGiftBag.swift
//  Pods
//
//  Created by Pi0007 on 2025/4/23.
//

import Foundation

public class DGCChatMsgGiftBag: DGCChatMsg , Codable {
    public internal(set) var title = ""
    public internal(set) var content = ""
    public internal(set) var openUrl = ""
    public internal(set) var icon = ""
    public internal(set) var button = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case content
        case openUrl
        case icon
        case button
    }

    public func encode(to encoder: Encoder) throws {
        var dgc_container = encoder.container(keyedBy: CodingKeys.self)
        try dgc_container.encode(title, forKey: .title)
        try dgc_container.encode(content, forKey: .content)
        try dgc_container.encode(openUrl, forKey: .openUrl)
        try dgc_container.encode(icon, forKey: .icon)
        try dgc_container.encode(button, forKey: .button)
    }

    required public init(from decoder: Decoder) throws {
        super.init()
        let dgc_container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = .GiftBag
        title = (try? dgc_container.decode(String.self, forKey: .title)) ?? ""
        content = (try? dgc_container.decode(String.self, forKey: .content)) ?? ""
        openUrl = (try? dgc_container.decode(String.self, forKey: .openUrl)) ?? ""
        icon = (try? dgc_container.decode(String.self, forKey: .icon)) ?? ""
        button = (try? dgc_container.decode(String.self, forKey: .button)) ?? ""
    }
}
