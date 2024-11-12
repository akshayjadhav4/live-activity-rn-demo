//
//  Attributes.swift
//  OrderTracking
//
//  Created by Akshay Anil Jadhav on 07/11/24.
//

import ActivityKit
import SwiftUI
import ExpoModulesCore

struct OrderTrackingActivityAttributes: ActivityAttributes {
    
  public struct ContentState: Codable, Hashable {
          var packageStatus: PackageStatus
          var estimatedDeliveryTime: Date?
      }

      // Enum to represent different package statuses
    enum PackageStatus: String, Codable, Hashable, Enumerable {
          case shipped = "Shipped"
          case inTransit = "In Transit"
          case outForDelivery = "Out for Delivery"
          case delivered = "Delivered"
          case cancelled = "Cancelled"
      }
      
      // Attributes that do not change over the activity's lifecycle
      var trackingNumber: String
      var carrierName: String
}
