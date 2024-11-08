//
//  OrderTrackingActivity.swift
//  Order Tracking Live Activity
//
//  Created by Akshay Anil Jadhav on 06/11/24.
//


import ActivityKit
import SwiftUI
import WidgetKit

private func symbolForStatus(_ status: OrderTrackingActivityAttributes.PackageStatus) -> String {
    switch status {
    case .shipped:
        return "shippingbox"
    case .inTransit:
        return "arrow.right"
    case .outForDelivery:
        return "car"
    case .delivered:
        return "house.fill"
    }
}

struct TrackingProgressView: View {
    let context: ActivityViewContext<OrderTrackingActivityAttributes>
    
    var body: some View {
      VStack(alignment: .leading) {
          Text("Tracking Number: \(context.attributes.trackingNumber)")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(context.attributes.carrierName)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
            
          HStack(spacing: 10) {
                          ForEach(OrderTrackingActivityAttributes.PackageStatus.allCases, id: \.self) { status in
                              VStack {
                                Image(systemName: status.iconName)
                                                            .font(.subheadline)
                                                            .foregroundColor(color(for: status))
                              }
                              if status != .delivered {
                                  ProgressView(value: progressValue(for: status))
                                      .progressViewStyle(LinearProgressViewStyle(tint: color(for: status)))
                                      .frame(height: 4)
                              }
                          }
                      }
          .padding(.vertical)
          Text(context.state.packageStatus.rawValue)
              .font(.caption)
              .foregroundColor(.green)
        }
        .padding()
        .activityBackgroundTint(Color.black.opacity(0.5))
    }
  
  // Determine color based on the status
      private func color(for status: OrderTrackingActivityAttributes.PackageStatus) -> Color {
          let currentStatusIndex = OrderTrackingActivityAttributes.PackageStatus.allCases.firstIndex(of: context.state.packageStatus) ?? 0
          let statusIndex = OrderTrackingActivityAttributes.PackageStatus.allCases.firstIndex(of: status) ?? 0
          
          if statusIndex < currentStatusIndex {
              return .green // Completed
          } else if statusIndex == currentStatusIndex {
              return .blue // Active
          } else {
              return .gray // Incomplete
          }
      }
  
  // Calculate progress value for each status based on completion level
      private func progressValue(for status: OrderTrackingActivityAttributes.PackageStatus) -> Double {
          let currentStatusIndex = OrderTrackingActivityAttributes.PackageStatus.allCases.firstIndex(of: context.state.packageStatus) ?? 0
          let statusIndex = OrderTrackingActivityAttributes.PackageStatus.allCases.firstIndex(of: status) ?? 0

          if statusIndex < currentStatusIndex {
              return 1.0 // Completed (fully filled)
          } else if statusIndex == currentStatusIndex {
              return 0.5 // Active (half-filled)
          } else {
              return 0.0 // Incomplete (empty)
          }
      }
}

struct OrderTrackingLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderTrackingActivityAttributes.self) { context in
            // Lock Screen
          TrackingProgressView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded view in Dynamic Island
              DynamicIslandExpandedRegion(.leading) {
                Image(systemName: symbolForStatus(context.state.packageStatus))
                  .font(.title)
                  .foregroundColor(.green)
              }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text(context.attributes.trackingNumber)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
              DynamicIslandExpandedRegion(.bottom) {
                Text(context.state.packageStatus.rawValue)
                      .font(.title)
                      .foregroundColor(.white)
              }
              
              
            } compactLeading: {
              Text(context.state.packageStatus.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } compactTrailing: {
              Image(systemName: symbolForStatus(context.state.packageStatus))
                .foregroundColor(.green)
            } minimal: {
              Image(systemName: symbolForStatus(context.state.packageStatus))
                .foregroundColor(.green)
            }
        }
    }
}



extension OrderTrackingActivityAttributes.PackageStatus {
    // Associate icons with each status using SF Symbols
    var iconName: String {
        switch self {
        case .shipped: return "shippingbox.fill"
        case .inTransit: return "arrow.right"
        case .outForDelivery: return "car.fill"
        case .delivered: return "house.fill"
        }
    }
}

extension OrderTrackingActivityAttributes {
  fileprivate static var preview: OrderTrackingActivityAttributes {
      OrderTrackingActivityAttributes(trackingNumber: "1Z9999", carrierName: "Fast Shipping Co.")
    }
}

extension OrderTrackingActivityAttributes.ContentState {
  fileprivate static var shipped: OrderTrackingActivityAttributes.ContentState {
      OrderTrackingActivityAttributes.ContentState(packageStatus: .shipped, estimatedDeliveryTime: Date().addingTimeInterval(3600 * 5))
    }
    
  fileprivate static var inTransit: OrderTrackingActivityAttributes.ContentState {
      OrderTrackingActivityAttributes.ContentState(packageStatus: .inTransit, estimatedDeliveryTime: Date().addingTimeInterval(3600 * 3))
    }
    
  fileprivate static var outForDelivery: OrderTrackingActivityAttributes.ContentState {
      OrderTrackingActivityAttributes.ContentState(packageStatus: .outForDelivery, estimatedDeliveryTime: Date().addingTimeInterval(3600 * 1))
    }
    
  fileprivate static var delivered: OrderTrackingActivityAttributes.ContentState {
      OrderTrackingActivityAttributes.ContentState(packageStatus: .delivered, estimatedDeliveryTime: nil)
    }
}


#Preview("Package Tracking Notification", as: .content, using: OrderTrackingActivityAttributes.preview) {
  OrderTrackingLiveActivity() // Main view for the widget
} contentStates: {
  OrderTrackingActivityAttributes.ContentState.shipped
//  OrderTrackingActivityAttributes.ContentState.inTransit
//  OrderTrackingActivityAttributes.ContentState.outForDelivery
//  OrderTrackingActivityAttributes.ContentState.delivered
}
