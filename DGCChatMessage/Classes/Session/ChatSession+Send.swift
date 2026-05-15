//
//  DGCChatSession+Send.swift
//  Pods
//
//  Created by Pi0007 on 2026/3/8.
//

import Foundation

// 消息发送
extension DGCChatSession {
    
    /// 发送消息
    /// dgc_msg 消息
    /// isNeedVail 是否需要校验
    public func sendMsg(_ dgc_msg : DGCChatMsg,isNeedVail : Bool = true, success : ChatEmptyBlock? = nil,fail : ChatFailBlock? = nil) {
        if isNeedVail {
            //验证消息是否能发送
            let dgc_isVail = delegate?.chatSessionVailCanSendMsg() ?? true
            if dgc_isVail == false{return}
        }
        manager.callInQueue {[weak self] in
            self?.dgc_sendMsg(dgc_msg, success: success, fail: fail)
        }
    }
    
    ///重新发送消息
    public func reSendMsg(_ dgc_msg: DGCChatMsg, isNeedVail : Bool = true, success : ChatEmptyBlock? = nil,fail : ChatFailBlock? = nil) {
        if isNeedVail {
            //验证消息是否能发送
            let dgc_isVail = delegate?.chatSessionVailCanSendMsg() ?? true
            if dgc_isVail == false{return}
        }
        //将消息先移除在发送
        msgArr.removeAll(where: {$0.mID == dgc_msg.mID})
        manager.dgc_handler.deleteMsg(session: self, msgId: dgc_msg.mID, success: {}, fail: {_,_ in })
        manager.callInQueue {[weak self] in
            self?.dgc_sendMsg(dgc_msg, success: success, fail: fail)
        }
    }
    
    ///发送提示消息 tipText 内容
    public func sendTipMsg(_ tipText:String, success : ChatEmptyBlock? = nil,fail : ChatFailBlock? = nil) {
        DGCChatManager.share.delegate?.chatManagerShowTipMsg(tipText: tipText, session: self,success: { [weak self] in
            guard let dgc_self = self else { return }
            dgc_self.callOnRefreshMsgList()
        }, fail: nil)
    }
    
    /// 发送消息
    private func dgc_sendMsg(_ dgc_msg : DGCChatMsg, success : ChatEmptyBlock? = nil,fail : ChatFailBlock? = nil) {
        //发送前的检测
//        beforeChecke(dgc_msg: dgc_msg)
        dgc_msg.sendState = .Sending
        //先将消息插入列表
        sendBeforeInsertMsgToList(dgc_msg: dgc_msg)
        dgc_innerSendMsg(dgc_msg,success: success,fail: fail)
        sendEndNotiRefresh(dgc_msg: dgc_msg)
    }
    
    // 内部发送消息
    private func dgc_innerSendMsg(_ dgc_msg : DGCChatMsg, success : ChatEmptyBlock? = nil,fail : ChatFailBlock? = nil) {
        manager.sendMsg(session: self, msg: dgc_msg) {[weak self] in
            dgc_msg.sendState = .OK
            success?()
            self?.dgc_innerSendHandleSuccess(dgc_msg: dgc_msg)
            self?.callOnRefreshMsgList()
        } fail: {[weak self] code, err in
            dgc_msg.sendState = .Fail
            self?.dgc_innerSendHandleFail(dgc_msg: dgc_msg, code: code, errString: err)
            self?.callOnRefreshMsgList()
            fail?(code,err)
        }
    }
    
//    private func dgc_sendGiftMsg(_ dgc_msg: DGCChatMsg) {
//        guard let dgc_msg = dgc_msg as? DGCChatMsgGift else { return }
//        manager.delegate?.chatManagerSendGift(dgc_msg: dgc_msg, success: { [weak self] in
//            dgc_msg.sendState = .OK
//            self?.callOnRefreshMsgList()
//        }, fail: { [weak self] code, errMsg in
//            dgc_msg.sendState = .Fail
//            self?.dgc_innerSendHandleFail(dgc_msg: dgc_msg, code: code, errString: errMsg)
//            self?.callOnRefreshMsgList()
//        })
//    }
    
    private func dgc_innerSendHandleFail(dgc_msg: DGCChatMsg, code: Int32, errString: String?) {
        DGCChatManager.share.delegate?.chatManagerMsgGlobalSendFail(session: self, msg: dgc_msg, code: code, errString: errString)
    }
    
    
    private func dgc_innerSendHandleSuccess(dgc_msg: DGCChatMsg) {
        DGCChatManager.share.delegate?.chatManagerMsgGlobalSendSuccess(session: self, msg: dgc_msg)
    }
}
