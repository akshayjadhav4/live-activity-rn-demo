import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { OrderTrackingViewProps } from './OrderTracking.types';

const NativeView: React.ComponentType<OrderTrackingViewProps> =
  requireNativeViewManager('OrderTracking');

export default function OrderTrackingView(props: OrderTrackingViewProps) {
  return <NativeView {...props} />;
}
