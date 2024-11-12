//
//  OrderTrackingLiveActivityIntent.swift
//  liveactivityrn
//
//  Created by Akshay Anil Jadhav on 11/11/24.
//

import Foundation
import AppIntents
import os.log

// Select Target both App and Widget to LiveActivityIntent work

@available(iOS 17.0, *)
public struct CancelOrderIntent: LiveActivityIntent {
  public init() {}
    public static var title = LocalizedStringResource("Cancel Order")
    public func perform() async throws -> some IntentResult {
    os_log("CancelOrderIntent was triggered", log: OSLog.default, type: .info)
    NotificationCenter.default.post(name: Notification.Name("onOrderCancelEvent"), object: nil)
    return .result()
  }
}
