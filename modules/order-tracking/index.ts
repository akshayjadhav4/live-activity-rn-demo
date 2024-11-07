import {
  EndActivityParams,
  StartActivityParams,
  UpdateActivityParams,
} from "./src/OrderTracking.types";
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

export function updateActivity(options: UpdateActivityParams) {
  OrderTrackingModule.updateActivity(
    options.packageStatus,
    options.estimatedDeliveryTime
  );
}

export function endActivity(options: EndActivityParams) {
  return OrderTrackingModule.endActivity(
    options.packageStatus,
    options.estimatedDeliveryTime
  );
}
