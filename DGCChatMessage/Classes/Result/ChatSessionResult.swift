//
//  ChatSessionResult.swift
//  Pods
//
//  Created by Pi0007 on 2026/3/8.
//

import Foundation

/// 请求返回的会话数据
public struct ChatSessionResult {
    var list = [DGCChatSession]()
    var page : Int32 = 0
    var isFinished = false
}


/// 请求返回的消息数据
public struct ChatMsgResult {
    var list = [DGCChatMsg]()
    var page : Int32 = 0
    var isFinished = false
}
