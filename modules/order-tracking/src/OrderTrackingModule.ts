import { PackageStatus } from "./OrderTracking.types";
import { EventEmitter } from "expo-modules-core";

export default {
  areActivitiesEnabled: () => false,
  isActivityInProgress: () => false,
  startActivity(
    trackingNumber: string,
    carrierName: string,
    packageStatus: PackageStatus,
    estimatedDeliveryTime: number
  ) {
    return false;
  },
  updateActivity(
    packageStatus: PackageStatus,
    estimatedDeliveryTime: number
  ) {},
  endActivity(packageStatus: PackageStatus, estimatedDeliveryTime: number) {},
};

const emitter = {} as EventEmitter;
export { emitter };
