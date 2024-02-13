//
//  DummayObject.swift
//  CometChatSwift
//
//  Created by SuryanshBisen on 15/12/23.
//  Copyright © 2023 MacMini-03. All rights reserved.
//

import Foundation
import CometChatSDK

#if canImport(CometChatCallsSDK)
import CometChatCallsSDK
#endif


class DummyObject {
    
#if canImport(CometChatCallsSDK)
    static func callLog(user: User?) -> CallLog {
        
        let participantDic = [
          [
            "uid": "superhero1",
            "totalAudioMinutes": 0,
            "totalVideoMinutes": 0.5666666666666667,
            "isJoined": true,
            "totalDurationInMinutes": 0.5666666666666667,
            "state": "ended",
            "deviceId": "",
            "joinedAt": 1702564682,
            "mid": "",
            "leftAt": 1702564716,
            "name": "Iron Man",
            "avatar": "https://data-us.cometchat.io/assets/images/avatars/ironman.png"
          ],
          [
            "uid": "superhero2",
            "totalAudioMinutes": 0,
            "totalVideoMinutes": 0.48333333333333334,
            "isJoined": true,
            "state": "ended",
            "totalDurationInMinutes": 0.48333333333333334,
            "deviceId": "9bed21c5-bde5-4d44-9804-d6c1616d4082@rtc-us.cometchat.io/9EHnT6Do",
            "joinedAt": 1702564688,
            "mid": "98bb98d0-d97d-4d7c-892f-99859e1dbf8e",
            "leftAt": 1702564717,
            "name": "Captain America",
            "avatar": "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png"
          ]
        ]
        
        let recordingDic = [
            [
                "duration": 49.607,
                "endTime": 1702558017,
                "recording_url": "https://recordings-us.cometchat.io/236497dcc2cd529b/2023-12-15/v1.us.236497dcc2cd529b.17026412504ace8fb4f82076d8c38b8783bb94e1e88c793ba2_2023-12-15-11-54-48.mp4",
                "rid": "avytyitteihuyqfd",
                "startTime": 1702557867
            ]
        ]
        
        let callLog = CallLog()
        callLog.startedAt = 1702575653
        callLog.endedAt = 1702575673
        callLog.status = .ended
        callLog.totalParticipants = 2
        callLog.totalDurationInMinutes = 0.3333333333333333
        callLog.totalVideoMinutes = 0.3333333333333333
        callLog.type = .video
        
        let participantData = (try? JSONSerialization.data(withJSONObject: participantDic)) ?? Data()
        let participants = (try? JSONDecoder().decode([Participant].self, from: participantData)) ?? [Participant]()
        callLog.participants = participants
        
        let recordingData = (try? JSONSerialization.data(withJSONObject: recordingDic)) ?? Data()
        let recording = (try? JSONDecoder().decode([Recording].self, from: recordingData)) ?? [Recording]()
        callLog.recordings = recording
        
        let initiator = CallUser()
        initiator.uid = user?.uid ?? ""
        initiator.avatar = user?.avatar ?? ""
        initiator.name = user?.name ?? ""
        
        let receiver = CallUser()
        receiver.uid = user?.uid != "superhero2" ? "superhero2" : "superhero1"
        receiver.avatar = user?.uid != "superhero2" ? "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png" : "https://data-us.cometchat.io/assets/images/avatars/ironman.png"
        receiver.name = user?.uid != "superhero2" ? "Captain America" : "Iron Man"
        callLog.receiver = receiver
        
        return callLog
        
    }
#endif
    
}
