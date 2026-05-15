//
//  DGCChatMsgText.swift
//  VLDLive
//
//  Created by Pi0007 on 2026/3/7.
//

import Foundation

// 文本消息
public class DGCChatMsgText: DGCChatMsg {
    
    private override init() {
        super.init()
        type = .Text
    }
    
    // 文本内容
    public internal(set) var text = String()
    
    public convenience init(text : String) {
        self.init()
        self.text = text
    }
}
