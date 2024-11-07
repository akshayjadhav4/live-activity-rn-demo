export enum PackageStatus {
  Shipped = "Shipped",
  InTransit = "In Transit",
  OutForDelivery = "Out for Delivery",
  Delivered = "Delivered",
}

export interface StartActivityParams {
  trackingNumber: string;
  carrierName: string;
  packageStatus: PackageStatus;
  estimatedDeliveryTime: number;
}

export interface UpdateActivityParams {
  packageStatus: PackageStatus;
  estimatedDeliveryTime: number;
}

export interface EndActivityParams extends UpdateActivityParams {}
