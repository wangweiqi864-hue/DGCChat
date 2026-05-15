//
//  DGCChatMsgLocalTip.swift
//  Pods
//
//  Created by Pi0007 on 2026/3/11.
//

import Foundation

public class DGCChatMsgLocalTip: DGCChatMsg, Codable {
    
    public var keywordsRects: [CGRect] = []
    public var keywordsTapBlocks: [(_ keyword:String)->()] = []
    
    public internal(set) var tipText: String = String()
    // 本地多语言的key
    public internal(set) var languageKey: String?
    
    public internal(set) var isRichText: Bool = false
    
    public internal(set) var keywords: [String] = []
    
    public init(tipText: String, languageKey: String? = nil,isRichText: Bool = false,keywords: [String] = []) {
        super.init()
        self.type = .Tip
        self.tipText = tipText
        self.languageKey = languageKey
        self.isRichText = isRichText
        self.keywords = keywords
        self.isLocal = true
    }
    
    required public init(from decoder: Decoder) throws {
        super.init()
        self.type = .Tip
        self.isLocal = true
        
        let dgc_container = try decoder.container(keyedBy: CodingKeys.self)
        self.languageKey = try? dgc_container.decode(String.self, forKey: .languageKey)
        self.tipText = (try? dgc_container.decode(String.self, forKey: .tipText)) ?? ""
        self.isRichText = (try? dgc_container.decode(Bool.self, forKey: .isRichText)) ?? false
        self.keywords = (try? dgc_container.decode([String].self, forKey: .keywords)) ?? []
    }
    
    enum CodingKeys: CodingKey {
        case tipText
        case languageKey
        case isRichText
        case keywords
    }
    
    public func encode(to encoder: Encoder) throws {
        var dgc_container = encoder.container(keyedBy: CodingKeys.self)
        try dgc_container.encode(self.tipText, forKey: .tipText)
        try dgc_container.encode(self.languageKey, forKey: .languageKey)
        try dgc_container.encode(self.isRichText, forKey: .isRichText)
        try dgc_container.encode(self.keywords, forKey: .keywords)
    }
}
