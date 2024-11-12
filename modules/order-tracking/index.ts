import {
  EndActivityParams,
  PackageStatus,
  StartActivityParams,
  UpdateActivityParams,
} from "./src/OrderTracking.types";
import OrderTrackingModule, { emitter } from "./src/OrderTrackingModule";
import { Subscription } from "expo-modules-core";

export function areActivitiesEnabled(): boolean {
  return OrderTrackingModule.areActivitiesEnabled();
}

export function isActivityInProgress(): boolean {
  return OrderTrackingModule.isActivityInProgress();
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

export type PackageStatusChangeEvent = {
  status: PackageStatus;
};

export function addOrderCancelEventListener(
  listener: (event: PackageStatusChangeEvent) => void
): Subscription {
  return emitter.addListener<PackageStatusChangeEvent>(
    "onOrderCancelEvent",
    listener
  );
}

export { PackageStatus };
