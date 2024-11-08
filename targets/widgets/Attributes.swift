//
//  Attributes.swift
//  Order Tracking Live Activity
//
//  Created by Akshay Anil Jadhav on 06/11/24.
//

import ActivityKit
import SwiftUI

struct OrderTrackingActivityAttributes: ActivityAttributes {
    
  public struct ContentState: Codable, Hashable {
          var packageStatus: PackageStatus
          var estimatedDeliveryTime: Date?
      }

      // Enum to represent different package statuses
      enum PackageStatus: String, Codable, Hashable, CaseIterable {
          case shipped = "Shipped"
          case inTransit = "In Transit"
          case outForDelivery = "Out for Delivery"
          case delivered = "Delivered"
      }
      
      // Attributes that do not change over the activity's lifecycle
      var trackingNumber: String
      var carrierName: String
}

