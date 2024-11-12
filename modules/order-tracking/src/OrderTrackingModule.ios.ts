import { EventEmitter, requireNativeModule } from "expo-modules-core";

const ExpoSettingsModule = requireNativeModule("OrderTracking");

const emitter = new EventEmitter(ExpoSettingsModule);
export default ExpoSettingsModule;

export { emitter };
