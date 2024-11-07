import ExpoModulesCore
import ActivityKit

public class OrderTrackingModule: Module {
    
    public func definition() -> ModuleDefinition {
        
        Name("OrderTracking")
        
        Function("areActivitiesEnabled") { () -> Bool in
            if #available(iOS 16.2, *) {
                return ActivityAuthorizationInfo().areActivitiesEnabled
            } else {
                return false
            }
        }
        
        Function("startActivity") { (trackingNumber: String, carrierName: String, packageStatus: OrderTrackingActivityAttributes.PackageStatus, estimatedDeliveryTime: UInt64) -> Bool in
            if #available(iOS 16.2, *) {
                let attributes = OrderTrackingActivityAttributes(
                    trackingNumber: trackingNumber,
                    carrierName: carrierName
                )
                let contentState = OrderTrackingActivityAttributes.ContentState(
                    packageStatus: packageStatus,
                    estimatedDeliveryTime: Date(timeIntervalSince1970: TimeInterval(estimatedDeliveryTime))
                )
                let activityContent = ActivityContent(state: contentState, staleDate: nil)
                do {
                    let activity = try Activity.request(attributes: attributes, content: activityContent)
                    
                    return true
                } catch (let error) {
                    
                    return false
                }
            } else {
                return false
            }
            
        }
        
        Function("updateActivity") { (packageStatus: OrderTrackingActivityAttributes.PackageStatus, estimatedDeliveryTime: UInt64) -> Void in
            
            if #available(iOS 16.2, *) {
                
                let updatedContentState = OrderTrackingActivityAttributes.ContentState(
                    packageStatus: packageStatus,
                    estimatedDeliveryTime: Date(timeIntervalSince1970: TimeInterval(estimatedDeliveryTime))
                )
                
                Task {
                    for activity in Activity<OrderTrackingActivityAttributes>.activities {
                        await activity.update(using: updatedContentState)
                    }
                }
            }
        }
        
        Function("endActivity") { (packageStatus: OrderTrackingActivityAttributes.PackageStatus, estimatedDeliveryTime: UInt64) -> Void in
            
            if #available(iOS 16.2, *) {
                let contentState = OrderTrackingActivityAttributes.ContentState(
                    packageStatus: packageStatus,
                    estimatedDeliveryTime: Date(timeIntervalSince1970: TimeInterval(estimatedDeliveryTime))
                )
                let finalContent = ActivityContent(state: contentState, staleDate: nil)
                
                Task {
                    for activity in Activity<OrderTrackingActivityAttributes>.activities {
                        await activity.end(finalContent, dismissalPolicy: .immediate)
                    }
                }
            }
        }

    }
}
