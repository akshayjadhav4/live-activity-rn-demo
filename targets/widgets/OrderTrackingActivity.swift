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

struct ProgressStepView: View {
    let status: OrderTrackingActivityAttributes.PackageStatus
    let currentStatus: OrderTrackingActivityAttributes.PackageStatus

    var body: some View {
        VStack {
            Image(systemName: symbolForStatus(status))
                .foregroundColor(statusColor)
            
            Text(status.rawValue)
                .font(.caption2)
                .foregroundColor(statusColor)
        }
    }

  private var statusColor: Color {
      if currentStatus == status {
          return .green // Current step
      } else if isPastStep {
          return .green // Past steps
      } else {
          return .gray // Future steps
      }
  }

  private var isPastStep: Bool {
      // Determine the order of statuses to compare
      let order: [OrderTrackingActivityAttributes.PackageStatus] = [.shipped, .inTransit, .outForDelivery, .delivered]
      guard let currentIndex = order.firstIndex(of: currentStatus),
            let stepIndex = order.firstIndex(of: status) else {
          return false
      }
      return currentIndex > stepIndex
  }

}

struct OrderTrackingLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderTrackingActivityAttributes.self) { context in
            // Lock Screen
          VStack(alignment: .leading) {
              Text("Tracking Number: \(context.attributes.trackingNumber)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(context.attributes.carrierName)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            HStack(spacing: 10) {
                                ProgressStepView(status: .shipped, currentStatus: context.state.packageStatus)
                                ProgressStepView(status: .inTransit, currentStatus: context.state.packageStatus)
                                ProgressStepView(status: .outForDelivery, currentStatus: context.state.packageStatus)
                                ProgressStepView(status: .delivered, currentStatus: context.state.packageStatus)
                            }
                            .padding(.top, 10)
            }
            .padding()
            .activityBackgroundTint(.black.opacity(0.25))
            .cornerRadius(6)
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
