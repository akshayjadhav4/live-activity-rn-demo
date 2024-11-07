import { NativeModulesProxy, EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to OrderTracking.web.ts
// and on native platforms to OrderTracking.ts
import OrderTrackingModule from './src/OrderTrackingModule';
import OrderTrackingView from './src/OrderTrackingView';
import { ChangeEventPayload, OrderTrackingViewProps } from './src/OrderTracking.types';

// Get the native constant value.
export const PI = OrderTrackingModule.PI;

export function hello(): string {
  return OrderTrackingModule.hello();
}

export async function setValueAsync(value: string) {
  return await OrderTrackingModule.setValueAsync(value);
}

const emitter = new EventEmitter(OrderTrackingModule ?? NativeModulesProxy.OrderTracking);

export function addChangeListener(listener: (event: ChangeEventPayload) => void): Subscription {
  return emitter.addListener<ChangeEventPayload>('onChange', listener);
}

export { OrderTrackingView, OrderTrackingViewProps, ChangeEventPayload };
