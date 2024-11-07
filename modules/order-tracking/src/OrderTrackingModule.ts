import { PackageStatus } from "./OrderTracking.types";

export default {
  areActivitiesEnabled: () => false,
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
