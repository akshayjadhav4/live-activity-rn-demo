import { StartActivityParams } from "./src/OrderTracking.types";
import OrderTrackingModule from "./src/OrderTrackingModule";

export function areActivitiesEnabled(): boolean {
  return OrderTrackingModule.areActivitiesEnabled();
}

export function startActivity(options: StartActivityParams): boolean {
  return OrderTrackingModule.startActivity(
    options.trackingNumber,
    options.carrierName,
    options.packageStatus,
    options.estimatedDeliveryTime
  );
}

export function updateActivity(options: StartActivityParams) {
  OrderTrackingModule.updateActivity(
    options.packageStatus,
    options.estimatedDeliveryTime
  );
}

export function endActivity(options: StartActivityParams) {
  return OrderTrackingModule.endActivity(
    options.packageStatus,
    options.estimatedDeliveryTime
  );
}
