//
//  ChatConstants.swift
//  VLDLive
//
//  Created by Pi0007 on 2026/3/7.
//

import Foundation
import DGCLog

// 会话类型
public enum ChatSessionType {
    case Un
    case User // 用户对用户
    case Group // 群聊
}


// 消息类型
public enum ChatMsgType {
    case Un
    case Text // 文本
    case Image // 图片
    case Expression // 表情
    case Voice // 语音
    case Video // 视频
    case Tip // 提示消息
    case Time // 时间消息 
    case Custom // 外部自定义的消息
    case Gift // 礼物
    case GuildInvite // 公会邀请
    case LiveInvite // 房间邀请
    case GiftBag // 活动礼包
    case RelationshipInvite // 关系邀请
    case RelationshipUnbind // 关系解绑相关
    case GiftTipOutRoom //不在房送礼
}
/// 消息拥有者
public enum ChatMsgOwnerType {
    case Un
    case System // 系统消息  如: tip
    case MySelf // 自己发送的消息
    case Friend // 他人的消息
}

/// 消息发送状态
public enum ChatMsgSendState {
    case Sending // 发送中
    case OK // 失败
    case Fail // 成功
    case Revoked // 撤回
}

// 消息读取状态
public enum ChatMsgReadState {
    case UnRead // 未读
    case Readed // 已读
}

// 消息 播放状态
public enum ChatMsgPlayState {
    case UnPlay // 未播放
    case Played // 已播放
}

// 初始化SDK的配置
public struct ChatSDKConfig {
    public var appId = String()
    public init(appId: String = String()) {
        self.appId = appId
    }
}


// 空回调
public typealias ChatEmptyBlock = (()->Void)

// 带数据回调
public typealias ChatDataBlock<T> = ((_ data : T)->Void)

// 错误
public typealias ChatFailBlock = ((Int32,String?)->Void)

/// 日志输出
internal func CMLog(_ msg : String, file: String = #file){
    DGCLog.log("IM--\(msg)",file: file)
}


/// 主线程回调
internal func ChatCallInMain(_ block :@escaping (()->Void)) {
    if Thread.isMainThread{
        block()
    }else{
        DispatchQueue.main.async {
            block()
        }
    }
}
