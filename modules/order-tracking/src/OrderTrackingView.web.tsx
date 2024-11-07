import * as React from 'react';

import { OrderTrackingViewProps } from './OrderTracking.types';

export default function OrderTrackingView(props: OrderTrackingViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
